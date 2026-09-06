import QtQuick
import QtQuick.Layouts

// One selectable device/network row inside a networking panel.
Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property string detail: ""
    property bool active: false

    signal clicked()

    implicitHeight: 34
    radius: Theme.moduleRadius
    color: mouse.containsMouse ? Theme.color8 : "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 10

        Text {
            color: root.active ? Theme.color3 : Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconFontSize
            text: root.icon
        }

        Text {
            Layout.fillWidth: true
            color: root.active ? Theme.color3 : Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 1
            font.bold: root.active
            elide: Text.ElideRight
            text: root.label
        }

        Text {
            color: Theme.color7
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 3
            text: root.detail
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
