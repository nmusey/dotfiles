import QtQuick

// A waybar-style "pill": rounded rect, background color, padded content row.
Rectangle {
    id: root

    default property alias content: row.data

    color: Theme.background
    radius: Theme.moduleRadius
    implicitWidth: row.implicitWidth + Theme.modulePadding * 2
    implicitHeight: Theme.barHeight - 8

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 6
    }
}
