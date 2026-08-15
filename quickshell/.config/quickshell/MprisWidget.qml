import QtQuick
import Quickshell.Services.Mpris

Item {
    id: root

    property var screen: null

    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null

    implicitWidth: player ? pill.implicitWidth : 0
    implicitHeight: Theme.barHeight - 8
    visible: player !== null

    BarModule {
        id: pill
        anchors.fill: parent

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconFontSize
            visible: root.player && !root.player.isPlaying
            text: ""
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
                return artist.length > 0 ? (title + " by " + artist) : title;
            }
        }
    }

    MouseArea {
        anchors.fill: pill
        hoverEnabled: true
        onEntered: MprisHover.preview(root.screen)
        onExited: MprisHover.schedulePreviewHide()
        onClicked: {
            if (MprisHover.pinned)
                MprisHover.close();
            else
                MprisHover.pin(root.screen);
        }
    }
}
