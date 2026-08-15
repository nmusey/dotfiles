import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property real volumeValue: sink && sink.audio ? sink.audio.volume : 0

    property bool _ready: false

    visible: false
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    onMutedChanged: if (root._ready) root.show()
    onVolumeValueChanged: if (root._ready) root.show()

    function show() {
        root.visible = true;
        hideTimer.restart();
    }

    // Pipewire's sink discovery is async, so the first real volume/muted
    // values can land well after startup — wait a beat before reacting to
    // changes, or the HUD flashes on launch.
    Timer {
        interval: 1000
        running: true
        onTriggered: root._ready = true
    }

    Timer {
        id: hideTimer
        interval: Theme.hudTimeout
        onTriggered: root.visible = false
    }

    BarModule {
        id: pill
        anchors.fill: parent

        Row {
            spacing: 10

            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize + 4
                text: root.muted ? "󰝟" : (root.volumeValue > 0.5 ? "󰕾" : "󰖀")
            }

            Rectangle {
                id: track
                anchors.verticalCenter: parent.verticalCenter
                width: Theme.hudBarWidth
                height: 6
                radius: 3
                color: Theme.color8

                Rectangle {
                    width: track.width * Math.min(root.volumeValue, 1)
                    height: track.height
                    radius: track.radius
                    color: root.muted ? Theme.color8 : Theme.color3
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                text: Math.round(root.volumeValue * 100) + "%"
            }
        }
    }
}
