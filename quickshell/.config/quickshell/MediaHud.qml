import QtQuick
import Quickshell.Services.Mpris

Item {
    id: root

    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null

    property bool _ready: false

    visible: false
    implicitWidth: player ? pill.implicitWidth : 0
    implicitHeight: pill.implicitHeight

    // Mpris player discovery is async, so the first isPlaying/trackTitle
    // values can land well after startup — wait a beat before reacting to
    // changes, or the HUD flashes on launch.
    Timer {
        interval: 1000
        running: true
        onTriggered: root._ready = true
    }

    Connections {
        target: root.player
        function onIsPlayingChanged() {
            if (root._ready)
                root.show();
        }
        function onTrackTitleChanged() {
            if (root._ready)
                root.show();
        }
    }

    function show() {
        if (!root.player)
            return;
        root.visible = true;
        hideTimer.restart();
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
                text: root.player && root.player.isPlaying ? "" : ""
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                text: {
                    if (!root.player)
                        return "";
                    const artist = root.player.trackArtist || "";
                    const title = root.player.trackTitle || "";
                    return artist.length > 0 ? (title + " — " + artist) : title;
                }
            }
        }
    }
}
