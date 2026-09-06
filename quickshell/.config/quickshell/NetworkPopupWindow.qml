import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// Drop-down card for the networking bubble group. Same "always visible:true,
// collapse via implicit size" approach as MediaExpandedWindow (wlr-layer-shell
// surfaces don't reliably remap once hidden), on the Overlay layer. Anchored
// under the right end of the bar where the networking icons live. Closing is a
// plain toggle: click the same icon again (see NetworkGroup).
PanelWindow {
    id: root

    readonly property bool shouldShow: NetworkPopup.panel !== "" && NetworkPopup.activeScreen === root.screen
    readonly property int cardWidth: 340

    color: "transparent"
    visible: true

    anchors {
        top: true
        right: true
    }

    margins {
        // Sit flush against the bar pill: bar's top margin (4) + pill height
        // (Theme.barHeight - 8) + the pill's centering offset (4) = barHeight.
        top: Theme.barHeight
        right: 8
    }

    implicitWidth: root.shouldShow ? root.cardWidth : 0
    implicitHeight: root.shouldShow ? card.implicitHeight : 0

    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:network-popup"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    Binding {
        target: Network
        property: "popupActive"
        value: NetworkPopup.panel !== ""
    }

    Item {
        id: revealClip
        anchors.top: parent.top
        anchors.right: parent.right
        width: root.cardWidth
        height: root.shouldShow ? card.implicitHeight : 0
        clip: true
        visible: height > 0

        Behavior on height {
            NumberAnimation {
                duration: 160
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            id: card
            anchors.top: parent.top
            width: root.cardWidth
            implicitHeight: content.implicitHeight + Theme.modulePadding * 2
            height: implicitHeight
            color: Theme.background
            radius: Theme.moduleRadius

            ColumnLayout {
                id: content
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Theme.modulePadding
                spacing: 0

                WifiPanel {
                    Layout.fillWidth: true
                    visible: NetworkPopup.panel === "wifi"
                }

                BluetoothPanel {
                    Layout.fillWidth: true
                    visible: NetworkPopup.panel === "bluetooth"
                }

                EthernetPanel {
                    Layout.fillWidth: true
                    visible: NetworkPopup.panel === "ethernet"
                }
            }
        }
    }
}
