import QtQuick

NetPanel {
    id: root

    function signalGlyph(strength) {
        if (strength >= 75)
            return "󰤨"; // 󰤨
        if (strength >= 50)
            return "󰤥"; // 󰤥
        if (strength >= 25)
            return "󰤢"; // 󰤢
        if (strength > 0)
            return "󰤟"; // 󰤟
        return "󰤜"; // 󰤜
    }

    title: "Wi-Fi"
    toggleChecked: Network.wifiEnabled
    onToggled: value => Network.setWifiEnabled(value)

    summary: {
        if (!Network.wifiEnabled)
            return "Wi-Fi off";
        if (!Network.wifiConnected)
            return "Not connected";
        return Network.wifiSsid + "  ·  " + Network.wifiSignal + "%  ·  ↓ " + Network._humanRate(Network.rxRate) + "   ↑ " + Network._humanRate(Network.txRate);
    }

    listContent: [
        Repeater {
            model: Network.wifiEnabled ? Network.accessPoints : []

            delegate: NetRow {
                required property var modelData
                width: parent ? parent.width : 0
                icon: root.signalGlyph(modelData.signal)
                label: modelData.ssid
                detail: modelData.signal + "%"
                active: modelData.active
                onClicked: {
                    if (modelData.active)
                        Network.disconnectWifi();
                    else
                        Network.connectAccessPoint(modelData.ssid);
                }
            }
        }
    ]
}
