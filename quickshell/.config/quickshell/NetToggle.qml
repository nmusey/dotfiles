import QtQuick

// Small pill switch used at the top of each networking panel.
Rectangle {
    id: root

    property bool checked: false
    signal toggled(bool value)

    implicitWidth: 44
    implicitHeight: 24
    radius: height / 2
    color: checked ? Theme.color3 : Theme.color8

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    Rectangle {
        width: 18
        height: 18
        radius: height / 2
        color: Theme.foreground
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? parent.width - width - 3 : 3

        Behavior on x {
            NumberAnimation {
                duration: 120
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled(!root.checked)
    }
}
