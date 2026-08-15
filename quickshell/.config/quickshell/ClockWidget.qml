import QtQuick
import QtQuick.Controls
import Quickshell

Item {
    id: root

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    BarModule {
        id: pill
        anchors.fill: parent

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            text: Qt.formatDateTime(clock.date, "hh:mm  MMMM dd, yyyy")
        }
    }

    MouseArea {
        anchors.fill: pill
        hoverEnabled: true
        onClicked: Quickshell.execDetached(["obsidian"])

        ToolTip.visible: containsMouse
        ToolTip.text: Qt.formatDateTime(clock.date, "dddd, MMMM d yyyy")
    }
}
