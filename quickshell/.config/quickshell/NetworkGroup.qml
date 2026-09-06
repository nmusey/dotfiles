import QtQuick
import Quickshell.Bluetooth

// The networking "bubble group": one visible pill holding a wifi, bluetooth
// and ethernet icon. Each icon only appears when the machine actually has
// that capability (a wifi radio / a bluetooth adapter / an ethernet port).
// Clicking an icon toggles its selector popup (NetworkPopupWindow).
Item {
    id: root

    property var screen: null

    readonly property var btAdapter: Bluetooth.defaultAdapter

    readonly property bool wifiShown: Network.wifiPresent
    readonly property bool btShown: btAdapter !== null
    readonly property bool ethShown: Network.ethPresent
    readonly property bool anyShown: wifiShown || btShown || ethShown

    implicitWidth: anyShown ? pill.implicitWidth : 0
    implicitHeight: pill.implicitHeight
    visible: anyShown

    function wifiGlyph() {
        if (!Network.wifiEnabled)
            return "󰤭"; // 󰤭 off
        if (!Network.wifiConnected)
            return "󰤯"; // 󰤯 on, no link
        const s = Network.wifiSignal;
        if (s >= 75)
            return "󰤨";
        if (s >= 50)
            return "󰤥";
        if (s >= 25)
            return "󰤢";
        return "󰤟";
    }

    BarModule {
        id: pill
        anchors.fill: parent

        Row {
            spacing: 12

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: root.wifiShown
                color: Network.wifiConnected ? Theme.color3 : Theme.foreground
                opacity: Network.wifiEnabled ? 1 : 0.45
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconFontSize
                text: root.wifiGlyph()

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    cursorShape: Qt.PointingHandCursor
                    onClicked: NetworkPopup.toggle("wifi", root.screen)
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: root.btShown
                readonly property bool btOn: root.btAdapter && root.btAdapter.enabled
                readonly property bool btConnected: {
                    if (!root.btAdapter)
                        return false;
                    return root.btAdapter.devices.values.some(d => d.connected);
                }
                color: btConnected ? Theme.color3 : Theme.foreground
                opacity: btOn ? 1 : 0.45
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconFontSize
                text: !btOn ? "󰂲" : (btConnected ? "󰂱" : "󰂯") // 󰂲 / 󰂱 / 󰂯

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    cursorShape: Qt.PointingHandCursor
                    onClicked: NetworkPopup.toggle("bluetooth", root.screen)
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: root.ethShown
                color: Network.ethConnected ? Theme.color3 : Theme.foreground
                opacity: Network.ethConnected ? 1 : 0.45
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconFontSize
                text: Network.ethConnected ? "󰈀" : "󰈂" // 󰈀 / 󰈂

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    cursorShape: Qt.PointingHandCursor
                    onClicked: NetworkPopup.toggle("ethernet", root.screen)
                }
            }
        }
    }
}
