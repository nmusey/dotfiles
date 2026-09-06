import QtQuick
import Quickshell.Bluetooth

NetPanel {
    id: root

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property var devices: adapter ? adapter.devices.values : []
    readonly property var connectedDevices: devices.filter(d => d.connected)

    title: "Bluetooth"
    toggleChecked: adapter ? adapter.enabled : false
    onToggled: value => {
        if (root.adapter)
            root.adapter.enabled = value;
    }

    summary: {
        if (!adapter)
            return "No adapter";
        if (!adapter.enabled)
            return "Bluetooth off";
        const paired = devices.length;
        if (connectedDevices.length === 0)
            return paired + (paired === 1 ? " device" : " devices") + "  ·  none connected"
                + (adapter.discovering ? "  ·  scanning…" : "");
        const first = connectedDevices[0];
        let s = connectedDevices.length + " connected  ·  " + first.name;
        if (first.batteryAvailable)
            s += "  ·  " + Math.round(first.battery * 100) + "%";
        return s;
    }

    // Discover devices only while the panel is actually on screen.
    property Binding _discovery: Binding {
        target: root.adapter
        property: "discovering"
        value: root.visible && root.adapter !== null && root.adapter.enabled
        when: root.adapter !== null
    }

    listContent: [
        Repeater {
            model: root.adapter && root.adapter.enabled ? root.devices : []

            delegate: NetRow {
                required property var modelData
                width: parent ? parent.width : 0
                icon: modelData.connected ? "󰂱" : "󰂯" // 󰂱 / 󰂯
                label: modelData.name || modelData.address
                detail: {
                    if (modelData.pairing || modelData.state === BluetoothDeviceState.Connecting)
                        return "…";
                    if (modelData.connected && modelData.batteryAvailable)
                        return Math.round(modelData.battery * 100) + "%";
                    if (modelData.connected)
                        return "connected";
                    if (modelData.paired)
                        return "paired";
                    return "";
                }
                active: modelData.connected
                onClicked: {
                    if (modelData.connected)
                        modelData.disconnect();
                    else
                        modelData.connect();
                }
            }
        }
    ]
}
