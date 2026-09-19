import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire

// Output-device selector that drops down from the bar's VolumeWidget pill on
// hover. Same "always visible:true, collapse via implicit size" approach as
// MediaExpandedWindow and NetworkPopupWindow (wlr-layer-shell surfaces don't
// reliably remap once hidden), on the Overlay layer so it renders above normal
// app windows. Sized to the card only, never full-screen — see
// MediaExpandedWindow's note on why a click-away catcher is avoided.
PanelWindow {
    id: root

    // Real output devices only. isSink is also true for per-app playback
    // streams, hence the isStream filter; nodes with no audio interface have
    // no volume to show or route to. All three properties are constant and
    // readable before a node is bound, so the list is stable from startup.
    readonly property var sinks: Pipewire.nodes.values.filter(n => n.isSink && !n.isStream && n.audio)

    readonly property bool shouldShow: AudioHover.hovered && AudioHover.activeScreen === root.screen && root.sinks.length > 0
    readonly property int cardWidth: 320

    // node.nick ("LG 32 FHD", "Scarlett 2i2 USB") is much easier to pick out of
    // a narrow list than the full description ("GA104 High Definition Audio
    // Controller Digital Stereo (HDMI) [LG 32 FHD]"), so prefer it and fall
    // back for nodes that don't set one.
    function labelFor(node) {
        return node.nickname || node.description || node.name || "";
    }

    // PipeWire reports no usable form factor here — device.icon-name comes back
    // as "audio-card-analog" for everything on this machine — so the glyph is a
    // guess off the bus and the name, with a plain speaker as the fallback.
    function glyphFor(node) {
        const name = (node.name || "").toLowerCase();
        const text = (node.description + " " + node.nickname).toLowerCase();
        if (node.properties["device.bus"] === "bluetooth" || name.startsWith("bluez"))
            return "󰂯";
        if (text.includes("headphone") || text.includes("headset"))
            return "󰋋";
        if (text.includes("hdmi") || text.includes("displayport"))
            return "󰍹";
        return "󰓃";
    }

    color: "transparent"
    visible: true

    anchors {
        top: true
        right: true
    }

    margins {
        // Sit flush against the bar pill: bar's top margin (4) + pill height
        // (Theme.barHeight - 8) + the pill's centering offset (4) = barHeight.
        // Flush matters more here than for the network popup, which opens on
        // click — the pointer has to cross from pill to card with no dead gap
        // in between for the hover to survive.
        top: Theme.barHeight
        right: AudioHover.rightInset
    }

    implicitWidth: root.shouldShow ? root.cardWidth : 0
    implicitHeight: root.shouldShow ? card.implicitHeight : 0

    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:audio-popup"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    // Volume and mute only populate on bound nodes, so every candidate has to
    // be tracked, not just the current default.
    PwObjectTracker {
        objects: root.sinks
    }

    Item {
        id: revealClip
        anchors.top: parent.top
        anchors.right: parent.right
        width: root.cardWidth
        height: root.shouldShow ? card.implicitHeight : 0
        clip: true
        visible: height > 0

        Behavior on height {
            NumberAnimation {
                duration: 160
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            id: card
            anchors.top: parent.top
            width: root.cardWidth
            implicitHeight: content.implicitHeight + Theme.modulePadding * 2
            height: implicitHeight
            color: Theme.background
            radius: Theme.moduleRadius

            // A HoverHandler rather than a MouseArea: the rows below have their
            // own hover-enabled MouseAreas for their highlight, and a covering
            // MouseArea would swallow that. Pointer handlers see the hover
            // regardless of what the child items accept.
            HoverHandler {
                onHoveredChanged: {
                    if (hovered)
                        AudioHover.keepOpen();
                    else
                        AudioHover.schedulePreviewHide();
                }
            }

            ColumnLayout {
                id: content
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Theme.modulePadding
                spacing: 0

                Text {
                    Layout.fillWidth: true
                    Layout.leftMargin: 8
                    Layout.bottomMargin: 4
                    color: Theme.color7
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize - 4
                    text: "OUTPUT"
                }

                Repeater {
                    model: root.sinks

                    NetRow {
                        required property var modelData

                        Layout.fillWidth: true
                        icon: root.glyphFor(modelData)
                        label: root.labelFor(modelData)
                        detail: modelData.audio.muted ? "muted" : Math.round(modelData.audio.volume * 100) + "%"
                        active: Pipewire.defaultAudioSink === modelData
                        onClicked: Pipewire.preferredDefaultAudioSink = modelData
                    }
                }
            }
        }
    }
}
