import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: bar

    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: 4
        left: 8
        right: 8
    }

    implicitHeight: Theme.barHeight

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell:bar"

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.moduleSpacing

        ClockWidget {}
        BarModule {
            Workspaces { screen: bar.screen }
        }
    }

    RowLayout {
        anchors.centerIn: parent

        MprisWidget {
            screen: bar.screen
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.moduleSpacing

        VolumeWidget {}
        NetworkGroup { screen: bar.screen }
        SystemGroup {}
        TrayWidget {}
    }
}
