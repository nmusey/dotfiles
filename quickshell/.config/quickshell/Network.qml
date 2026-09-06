pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// NetworkManager-backed state for the wifi + ethernet parts of the networking
// bubble group. Quickshell 0.3 has no NetworkManager service, so this polls
// `nmcli` on a timer (faster while a networking popup is open) and shells out
// for the mutating actions. Bluetooth is handled separately by the native
// Quickshell.Bluetooth service (see BluetoothPanel / NetworkGroup).
QtObject {
    id: root

    // ---- wifi ----
    property bool wifiPresent: false
    property string wifiDevice: ""
    property bool wifiEnabled: false
    property bool wifiConnected: false
    property string wifiSsid: ""
    property int wifiSignal: 0
    property string wifiIp: ""

    // ---- ethernet ----
    property bool ethPresent: false
    property string ethDevice: ""
    property bool ethConnected: false
    property string ethConnectionName: ""
    property string ethIp: ""
    property int ethSpeed: 0 // Mb/s, 0 = unknown

    // ---- throughput of the primary link (wifi if connected, else ethernet) ----
    property real rxRate: 0 // bytes/sec
    property real txRate: 0
    property string _rateDevice: ""
    property real _prevRx: -1
    property real _prevTx: -1
    property real _prevStamp: 0

    // ---- scan results (deduped by SSID, strongest signal wins) ----
    property var accessPoints: []

    // Set by the popup window while a networking panel is visible; speeds up
    // polling and enables active wifi rescans.
    property bool popupActive: false

    function _unescape(s) {
        return s.replace(/\\(.)/g, "$1");
    }

    function _humanBytes(n) {
        if (n < 1024)
            return Math.round(n) + " B";
        if (n < 1024 * 1024)
            return (n / 1024).toFixed(1) + " KB";
        if (n < 1024 * 1024 * 1024)
            return (n / (1024 * 1024)).toFixed(1) + " MB";
        return (n / (1024 * 1024 * 1024)).toFixed(2) + " GB";
    }

    function _humanRate(n) {
        return _humanBytes(n) + "/s";
    }

    // ---- actions ----
    function setWifiEnabled(on) {
        actionProc.exec(["nmcli", "radio", "wifi", on ? "on" : "off"]);
    }

    function disconnectWifi() {
        if (root.wifiDevice)
            actionProc.exec(["nmcli", "device", "disconnect", root.wifiDevice]);
    }

    function connectAccessPoint(ssid) {
        actionProc.exec(["nmcli", "-w", "15", "device", "wifi", "connect", ssid]);
    }

    function setEthernetEnabled(on) {
        if (!root.ethDevice)
            return;
        if (on)
            actionProc.exec(["nmcli", "device", "connect", root.ethDevice]);
        else
            actionProc.exec(["nmcli", "device", "disconnect", root.ethDevice]);
    }

    function refresh() {
        if (!statusProc.running)
            statusProc.running = true;
    }

    property Process actionProc: Process {
        function exec(cmd) {
            command = cmd;
            running = true;
        }
        onExited: refreshSoon.restart()
    }

    // nmcli propagates state changes asynchronously; re-poll a beat after any
    // action so the UI catches up.
    property Timer refreshSoon: Timer {
        interval: 700
        repeat: false
        onTriggered: root.refresh()
    }

    property Timer poll: Timer {
        interval: root.popupActive ? 3000 : 12000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    // Stage 1: radio state + device inventory.
    property Process statusProc: Process {
        command: ["sh", "-c", "nmcli -g WIFI radio; echo @@S@@; nmcli -g DEVICE,TYPE,STATE,CONNECTION device status"]
        stdout: StdioCollector {
            onStreamFinished: root._parseStatus(text)
        }
    }

    function _parseStatus(text) {
        const chunks = text.split("@@S@@");
        root.wifiEnabled = (chunks[0] || "").trim() === "enabled";

        let wifiDev = "";
        let ethDev = "";
        let wifiConn = false;
        let ethConn = false;
        let ethConnName = "";
        const lines = (chunks[1] || "").trim().split("\n");
        for (const line of lines) {
            if (!line)
                continue;
            const p = line.split(":");
            const dev = p[0];
            const type = p[1];
            const state = p[2];
            const conn = root._unescape(p.slice(3).join(":"));
            const connected = state === "connected";
            if (type === "wifi" && !wifiDev) {
                wifiDev = dev;
                wifiConn = connected;
            } else if (type === "ethernet" && state !== "unavailable" && !ethDev) {
                ethDev = dev;
                ethConn = connected;
                ethConnName = connected ? conn : "";
            }
        }

        root.wifiDevice = wifiDev;
        root.wifiPresent = wifiDev !== "";
        root.wifiConnected = wifiConn;
        if (!wifiConn) {
            root.wifiSsid = "";
            root.wifiSignal = 0;
            root.wifiIp = "";
        }

        root.ethDevice = ethDev;
        root.ethPresent = ethDev !== "";
        root.ethConnected = ethConn;
        root.ethConnectionName = ethConnName;
        if (!ethConn) {
            root.ethIp = "";
            root.ethSpeed = 0;
        }

        detailProc.kick(wifiDev, ethDev);
    }

    // Stage 2: per-device detail, scan list and byte counters in one shot.
    property Process detailProc: Process {
        property string wifiDev: ""
        property string ethDev: ""

        function kick(w, e) {
            if (running)
                return;
            wifiDev = w;
            ethDev = e;
            const rescan = root.popupActive ? "yes" : "no";
            const parts = [];
            if (w)
                parts.push(`nmcli -g GENERAL.CONNECTION,IP4.ADDRESS device show '${w}'`);
            parts.push("echo @@W@@");
            if (e)
                parts.push(`nmcli -g GENERAL.CONNECTION,IP4.ADDRESS,CAPABILITIES.SPEED device show '${e}'`);
            parts.push("echo @@E@@");
            if (w)
                parts.push(`nmcli -g IN-USE,SIGNAL,SSID device wifi list --rescan ${rescan}`);
            parts.push("echo @@L@@");
            const stat = p => `/sys/class/net/${p}/statistics`;
            const cats = [];
            if (w)
                cats.push(`${stat(w)}/rx_bytes`, `${stat(w)}/tx_bytes`);
            if (e)
                cats.push(`${stat(e)}/rx_bytes`, `${stat(e)}/tx_bytes`);
            if (cats.length)
                parts.push(`grep -H . ${cats.join(" ")} 2>/dev/null`);
            command = ["sh", "-c", parts.join("; ")];
            running = true;
        }

        stdout: StdioCollector {
            onStreamFinished: root._parseDetail(text, detailProc.wifiDev, detailProc.ethDev)
        }
    }

    function _parseDetail(text, wifiDev, ethDev) {
        const wSplit = text.split("@@W@@");
        const eSplit = (wSplit[1] || "").split("@@E@@");
        const lSplit = (eSplit[1] || "").split("@@L@@");
        const wifiBlock = (wSplit[0] || "").trim().split("\n");
        const ethBlock = (eSplit[0] || "").trim().split("\n");
        const listBlock = (lSplit[0] || "").trim().split("\n");
        const statBlock = (lSplit[1] || "").trim().split("\n");

        if (wifiDev && root.wifiConnected) {
            root.wifiSsid = (wifiBlock[0] || "").trim();
            root.wifiIp = (wifiBlock[1] || "").split("/")[0];
        }

        if (ethDev && root.ethConnected) {
            root.ethIp = (ethBlock[1] || "").split("/")[0];
            const speed = parseInt((ethBlock[2] || "").replace(/[^0-9]/g, ""), 10);
            root.ethSpeed = isNaN(speed) ? 0 : speed;
        }

        // scan list
        if (wifiDev) {
            const seen = ({});
            const aps = [];
            for (const line of listBlock) {
                if (!line)
                    continue;
                const p = line.split(":");
                const inUse = p[0].trim() === "*";
                const signal = parseInt(p[1], 10) || 0;
                const ssid = root._unescape(p.slice(2).join(":"));
                if (!ssid)
                    continue;
                // nmcli's IN-USE marker is unreliable, so treat the AP whose
                // SSID matches the active connection as the active one.
                const active = inUse || (root.wifiConnected && ssid === root.wifiSsid);
                if (active && root.wifiConnected)
                    root.wifiSignal = signal;
                const prev = seen[ssid];
                if (prev === undefined) {
                    seen[ssid] = aps.length;
                    aps.push({
                        ssid: ssid,
                        signal: signal,
                        active: active
                    });
                } else {
                    aps[prev].active = aps[prev].active || active;
                    if (signal > aps[prev].signal)
                        aps[prev].signal = signal;
                }
            }
            aps.sort((a, b) => b.signal - a.signal);
            root.accessPoints = aps;
        } else {
            root.accessPoints = [];
        }

        // byte counters -> rates
        const counts = ({});
        for (const line of statBlock) {
            const m = line.match(/net\/([^/]+)\/statistics\/(rx|tx)_bytes:(\d+)/);
            if (m)
                counts[m[1] + "_" + m[2]] = parseFloat(m[3]);
        }
        const primary = root.wifiConnected ? wifiDev : (root.ethConnected ? ethDev : "");
        const now = Date.now();
        if (primary && counts[primary + "_rx"] !== undefined) {
            const rx = counts[primary + "_rx"];
            const tx = counts[primary + "_tx"];
            if (root._rateDevice === primary && root._prevStamp > 0) {
                const dt = (now - root._prevStamp) / 1000;
                if (dt > 0) {
                    root.rxRate = Math.max(0, (rx - root._prevRx) / dt);
                    root.txRate = Math.max(0, (tx - root._prevTx) / dt);
                }
            } else {
                root.rxRate = 0;
                root.txRate = 0;
            }
            root._rateDevice = primary;
            root._prevRx = rx;
            root._prevTx = tx;
            root._prevStamp = now;
        } else {
            root.rxRate = 0;
            root.txRate = 0;
            root._rateDevice = "";
            root._prevStamp = 0;
        }
    }
}
