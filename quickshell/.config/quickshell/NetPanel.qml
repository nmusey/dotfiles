import QtQuick
import QtQuick.Layouts

// Shared chrome for a networking panel: title + on/off toggle on the header
// row, a one-line stats summary beneath it, then a scrolling device list.
ColumnLayout {
    id: root

    property string title: ""
    property bool toggleChecked: false
    property string summary: ""
    property alias listContent: listColumn.data

    signal toggled(bool value)

    spacing: 10

    RowLayout {
        Layout.fillWidth: true
        spacing: 10

        Text {
            Layout.fillWidth: true
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize + 1
            font.bold: true
            text: root.title
        }

        NetToggle {
            checked: root.toggleChecked
            onToggled: value => root.toggled(value)
        }
    }

    Text {
        Layout.fillWidth: true
        color: Theme.color7
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize - 2
        elide: Text.ElideRight
        text: root.summary
    }

    Flickable {
        id: flick
        Layout.fillWidth: true
        Layout.preferredHeight: Math.min(Math.max(listColumn.implicitHeight, 1), 300)
        contentWidth: width
        contentHeight: listColumn.implicitHeight
        clip: true
        interactive: contentHeight > height
        boundsBehavior: Flickable.StopAtBounds

        Column {
            id: listColumn
            width: flick.width
            spacing: 2
        }
    }
}
