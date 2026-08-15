import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

// Bigger "now playing" card that drops down from the bar's MprisWidget pill
// on hover/click. Same "always visible:true, collapse via implicit size"
// trick HudWindow uses (wlr-layer-shell surfaces don't reliably remap once
// hidden), on the Overlay layer so it renders above normal app windows
// instead of z-fighting them (a nested xdg_popup inherited the bar's Top
// layer and lost that fight).
//
// This window is only ever sized to the card itself — never full-screen.
// An earlier version doubled as a full-screen click-away catcher so
// clicking anywhere else would close it, but that meant a mapped,
// input-eating surface covering the whole output whenever shown; if that
// state ever got stuck (or the shell hung while it was up), it would block
// every click on the desktop with no way to recover but the keyboard. Not
// an acceptable risk for something that runs permanently in the
// background, so closing is a plain toggle instead: click the summary
// again (see MprisWidget) to close it.
PanelWindow {
    id: root

    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    readonly property bool shouldShow: (MprisHover.hovered || MprisHover.pinned) && MprisHover.activeScreen === root.screen && root.player !== null
    readonly property int cardWidth: 340

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property real volumeValue: sink && sink.audio ? sink.audio.volume : 0

    // MPRIS metadata rarely carries a release date (Spotify dropped
    // xesam:contentCreated support in 2019), so this stays blank there —
    // shown only for players that still report it.
    readonly property string releaseYear: {
        const created = player && player.metadata ? player.metadata["xesam:contentCreated"] : "";
        if (!created)
            return "";
        const year = new Date(created).getFullYear();
        return isNaN(year) ? "" : String(year);
    }

    color: "transparent"
    visible: true

    anchors {
        top: true
    }

    margins {
        top: 4 + Theme.barHeight + Theme.moduleSpacing
    }

    implicitWidth: root.shouldShow ? root.cardWidth : 0
    implicitHeight: root.shouldShow ? card.implicitHeight : 0

    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:media-expanded"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    Item {
        id: revealClip
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.cardWidth
        height: root.shouldShow ? card.implicitHeight : 0
        clip: true
        visible: height > 0

        Behavior on height {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            id: card
            anchors.top: parent.top
            width: root.cardWidth
            implicitHeight: column.implicitHeight + Theme.modulePadding * 2
            height: implicitHeight
            color: Theme.background
            radius: Theme.moduleRadius

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: MprisHover.preview(root.screen)
                onExited: {
                    if (!MprisHover.pinned)
                        MprisHover.schedulePreviewHide();
                }
            }

            ColumnLayout {
                id: column
                anchors.centerIn: parent
                width: root.cardWidth - Theme.modulePadding * 2
                spacing: 12

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 14

                    ClippingRectangle {
                        Layout.preferredWidth: 96
                        Layout.preferredHeight: 96
                        radius: Theme.moduleRadius
                        color: Theme.color8

                        Image {
                            anchors.fill: parent
                            source: root.player && root.player.trackArtUrl ? root.player.trackArtUrl : ""
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        Text {
                            Layout.fillWidth: true
                            color: Theme.foreground
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize + 2
                            font.bold: true
                            elide: Text.ElideRight
                            text: root.player ? (root.player.trackTitle || "") : ""
                        }

                        Text {
                            Layout.fillWidth: true
                            color: Theme.foreground
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize
                            elide: Text.ElideRight
                            text: root.player ? (root.player.trackArtist || "") : ""
                        }

                        Text {
                            Layout.fillWidth: true
                            color: Theme.color7
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize - 1
                            elide: Text.ElideRight
                            visible: text.length > 0
                            text: {
                                if (!root.player || !root.player.trackAlbum)
                                    return "";
                                return root.releaseYear.length > 0 ? (root.player.trackAlbum + " · " + root.releaseYear) : root.player.trackAlbum;
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 24

                    Text {
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.iconFontSize
                        opacity: root.player && root.player.canGoPrevious ? 1 : 0.4
                        text: "\uf048"

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -8
                            enabled: root.player && root.player.canGoPrevious
                            onClicked: root.player.previous()
                        }
                    }

                    Text {
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.iconFontSize + 4
                        opacity: root.player && root.player.canTogglePlaying ? 1 : 0.4
                        text: root.player && root.player.isPlaying ? "\uf04c" : "\uf04b"

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -8
                            enabled: root.player && root.player.canTogglePlaying
                            onClicked: root.player.togglePlaying()
                        }
                    }

                    Text {
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.iconFontSize
                        opacity: root.player && root.player.canGoNext ? 1 : 0.4
                        text: "\uf051"

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -8
                            enabled: root.player && root.player.canGoNext
                            onClicked: root.player.next()
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    Text {
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize
                        text: root.muted ? "" : (root.volumeValue > 0.5 ? "" : "")

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -6
                            onClicked: {
                                if (root.sink && root.sink.audio)
                                    root.sink.audio.muted = !root.sink.audio.muted;
                            }
                        }
                    }

                    Rectangle {
                        id: volTrack
                        Layout.fillWidth: true
                        Layout.preferredHeight: 6
                        radius: 3
                        color: Theme.color8

                        Rectangle {
                            width: volTrack.width * Math.min(root.volumeValue, 1)
                            height: volTrack.height
                            radius: volTrack.radius
                            color: root.muted ? Theme.color8 : Theme.color3
                        }

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -6
                            onPressed: mouse => volTrack.setFromX(mouse.x)
                            onPositionChanged: mouse => {
                                if (pressed)
                                    volTrack.setFromX(mouse.x);
                            }
                        }

                        function setFromX(x) {
                            if (!root.sink || !root.sink.audio)
                                return;
                            root.sink.audio.volume = Math.max(0, Math.min(1, x / volTrack.width));
                        }
                    }

                    Text {
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize - 1
                        text: Math.round(root.volumeValue * 100) + "%"
                    }
                }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    visible: root.player !== null
                    color: Theme.color8
                    radius: Theme.moduleRadius
                    implicitWidth: openLabel.implicitWidth + Theme.modulePadding * 2
                    implicitHeight: openLabel.implicitHeight + 10

                    Text {
                        id: openLabel
                        anchors.centerIn: parent
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize - 1
                        text: root.player && root.player.identity ? ("Open " + root.player.identity) : "Open"
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (!root.player)
                                return;
                            if (root.player.canRaise)
                                root.player.raise();
                            else if (root.player.desktopEntry)
                                Quickshell.execDetached(["gtk-launch", root.player.desktopEntry]);
                        }
                    }
                }
            }
        }
    }
}
