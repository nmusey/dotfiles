import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

Item {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property real volume: sink && sink.audio ? sink.audio.volume : 0

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

        ToolTip.visible: containsMouse
        ToolTip.text: Math.round(root.volume * 100) + "%"
    }
}
