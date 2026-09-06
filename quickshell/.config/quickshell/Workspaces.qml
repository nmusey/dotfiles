import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: root

    property var screen

    // Populate HyprlandToplevel.lastIpcObject (the class fallback below); the
    // Wayland app_id is live without it, but this keeps the fallback usable.
    Component.onCompleted: Hyprland.refreshToplevels()

    // Mirrors waybar's hyprland/workspaces window-rewrite map (same codepoints).
    readonly property var iconMap: ({
        "com.mitchellh.ghostty": "",
        "ghostty": "",
        "kitty": "",
        "zen": "󰖟",
        "firefox": "󰖟",
        "Firefox": "󰖟",
        "brave-browser": "󰖟",
        "Brave-browser": "󰖟",
        "spotify": "",
        "Spotify": "",
        "steam": "󰓓",
        "dolphin": "",
        "org.kde.dolphin": "",
        "obsidian": "",
        "Obsidian": "",
        "Obsidian.AppImage": "",
        "obsidian.AppImage": "",
        "com.obsidian.Obsidian": "",
        "Code": "",
        "discord": "",
        "Discord": ""
    })
    readonly property string defaultIcon: "󱂬"

    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: ws

            visible: modelData.monitor !== null && root.screen !== null
                && modelData.monitor.name === root.screen.name

            color: "transparent"
            radius: 4
            implicitWidth: label.implicitWidth + 10
            implicitHeight: label.implicitHeight + 4

            RowLayout {
                id: label
                anchors.centerIn: parent
                spacing: 4

                Text {
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    color: modelData.active ? Theme.color3
                        : (modelData.urgent ? Theme.color2 : Theme.foreground)
                    text: modelData.name
                }

                Text {
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.iconFontSize
                    color: modelData.active ? Theme.color3
                        : (modelData.urgent ? Theme.color2 : Theme.foreground)
                    text: {
                        const wins = modelData.toplevels.values;
                        if (wins.length === 0)
                            return root.defaultIcon;
                        return wins.map(function (t) {
                            // Prefer the live Wayland app_id; lastIpcObject is only
                            // populated after an explicit Hyprland.refreshToplevels().
                            const cls = (t.wayland && t.wayland.appId)
                                || (t.lastIpcObject && t.lastIpcObject.class)
                                || "";
                            return root.iconMap[cls] || root.defaultIcon;
                        }).join(" ");
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.activate()
            }
        }
    }
}
