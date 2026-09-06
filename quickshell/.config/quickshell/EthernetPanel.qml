import QtQuick

NetPanel {
    id: root

    title: "Ethernet"
    toggleChecked: Network.ethConnected
    onToggled: value => Network.setEthernetEnabled(value)

    summary: {
        if (!Network.ethConnected)
            return "Cable unplugged / disabled";
        let s = Network.ethConnectionName || "Wired";
        if (Network.ethSpeed > 0)
            s += "  ·  " + (Network.ethSpeed >= 1000 ? (Network.ethSpeed / 1000) + " Gb/s" : Network.ethSpeed + " Mb/s");
        s += "  ·  ↓ " + Network._humanRate(Network.rxRate) + "   ↑ " + Network._humanRate(Network.txRate);
        return s;
    }

    listContent: [
        NetRow {
            width: parent ? parent.width : 0
            visible: Network.ethConnected
            icon: "󰈀" // 󰈀
            label: Network.ethConnectionName || Network.ethDevice
            detail: Network.ethIp
            active: true
            onClicked: Network.setEthernetEnabled(false)
        },
        NetRow {
            width: parent ? parent.width : 0
            visible: !Network.ethConnected && Network.ethPresent
            icon: "󰈂" // 󰈂
            label: Network.ethDevice
            detail: "disconnected"
            active: false
            onClicked: Network.setEthernetEnabled(true)
        }
    ]
}
