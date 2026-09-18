import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root

    property var screen: null

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property real volume: sink && sink.audio ? sink.audio.volume : 0

    // Distance from the screen's right edge to this pill's right edge, so the
    // output selector can line up under it. The bar's right-hand row is
    // anchored to the bar's right edge, which itself sits 8px in (Bar.qml's
    // right margin) — so the offset within the row plus that margin is the
    // whole distance. Stays correct as sibling pills appear and resize.
    readonly property int rightInset: parent ? parent.width - (x + width) + 8 : 8

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    BarModule {
        id: pill
        anchors.fill: parent

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconFontSize
            text: root.muted ? "󰝟" : "󰕾"
        }
    }

    MouseArea {
        anchors.fill: pill
        hoverEnabled: true
        // Hovering opens the output selector (AudioPopupWindow), which shows
        // the current volume per device — so no tooltip here; it would only
        // overlap the card with a number the card already gives.
        onEntered: AudioHover.preview(root.screen, root.rightInset)
        onExited: AudioHover.schedulePreviewHide()
        onClicked: {
            if (root.sink && root.sink.audio)
                root.sink.audio.muted = !root.sink.audio.muted;
        }
        onWheel: wheel => {
            if (!root.sink || !root.sink.audio)
                return;
            const step = 0.05;
            const delta = wheel.angleDelta.y > 0 ? step : -step;
            root.sink.audio.volume = Math.max(0, Math.min(1.5, root.sink.audio.volume + delta));
        }
    }
}
