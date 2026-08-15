import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Item {
    id: root

    readonly property int iconSize: 21

    implicitWidth: SystemTray.items.values.length > 0 ? pill.implicitWidth : 0
    implicitHeight: Theme.barHeight - 8
    visible: SystemTray.items.values.length > 0

    BarModule {
        id: pill
        anchors.fill: parent

        Row {
            spacing: 10

            Repeater {
                model: SystemTray.items

                delegate: Item {
                    id: trayItem

                    required property var modelData

                    width: root.iconSize
                    height: root.iconSize

                    IconImage {
                        anchors.fill: parent
                        implicitSize: root.iconSize
                        source: trayItem.modelData.icon
                    }

                    QsMenuAnchor {
                        id: menuAnchor
                        menu: trayItem.modelData.menu
                        anchor.item: trayItem
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.RightButton) {
                                if (trayItem.modelData.hasMenu)
                                    menuAnchor.open();
                                else
                                    trayItem.modelData.secondaryActivate();
                            } else {
                                trayItem.modelData.activate();
                            }
                        }
                    }
                }
            }
        }
    }
}
