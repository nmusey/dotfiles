import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// Transient OSD-style popup: pops up on volume/media/mic changes, then fades
// itself out. Mirrors the bar's pill styling so it reads as the same UI.
//
// The window itself stays permanently mapped (visible: true) rather than
// toggling on the union of the pills' shown state. Quickshell's layer-shell
// surface is only ever created while the window is visible at map time; if
// it starts hidden, later flipping `visible` back to true updates the QML
// property but never actually maps a new wlr-layer-shell surface, so the
// HUD would never appear on screen. Keeping the window mapped and letting
// each pill collapse to zero size (via its own `visible`, which the
// ColumnLayout excludes from layout when false) avoids remapping entirely.
PanelWindow {
    id: hud

    color: "transparent"
    visible: true

    anchors {
        bottom: true
    }

    margins {
        bottom: Theme.hudBottomMargin
    }

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:hud"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: Theme.moduleSpacing

        VolumeHud {
            id: volumeHud
            Layout.alignment: Qt.AlignHCenter
        }

        MicHud {
            id: micHud
            Layout.alignment: Qt.AlignHCenter
        }

        MediaHud {
            id: mediaHud
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
