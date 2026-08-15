import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root

    readonly property var source: Pipewire.defaultAudioSource
    readonly property bool muted: source && source.audio ? source.audio.muted : false

    property bool _ready: false

    visible: false
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    PwObjectTracker {
        objects: root.source ? [root.source] : []
    }

    onMutedChanged: if (root._ready) root.show()

    function show() {
        root.visible = true;
        hideTimer.restart();
    }

    // Pipewire's source discovery is async, so the first real muted value
    // can land well after startup — wait a beat before reacting to changes,
    // or the HUD flashes on launch.
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
                text: root.muted ? "󰍭" : "󰍬"
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                text: root.muted ? "Mic muted" : "Mic unmuted"
            }
        }
    }
}
