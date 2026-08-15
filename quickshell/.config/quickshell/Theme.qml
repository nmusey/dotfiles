pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    // Fallback palette (current pywal generation at time of writing); overwritten
    // live from ~/.cache/wal/colors.json whenever wal regenerates it.
    property color background: "#0b1019"
    property color foreground: "#c2c3c5"
    property color color0: "#0b1019"
    property color color1: "#493d3b"
    property color color2: "#6f3d2d"
    property color color3: "#715246"
    property color color4: "#876757"
    property color color5: "#5b5f66"
    property color color6: "#8e7e77"
    property color color7: "#8e9299"
    property color color8: "#5a616e"
    property color color9: "#62524f"
    property color color10: "#95523c"
    property color color11: "#976e5e"
    property color color12: "#b58a74"
    property color color13: "#7a7f88"
    property color color14: "#bea99f"
    property color color15: "#c2c3c5"

    property int barHeight: 48
    property int moduleSpacing: 8
    property int modulePadding: 12
    property int moduleRadius: 8
    property string fontFamily: "Hasklug Nerd Font Mono"
    property int fontSize: 15
    // Nerd Font glyphs render visually smaller than text at the same pixel size.
    property int iconFontSize: fontSize + 3

    property int hudTimeout: 1800
    property int hudBottomMargin: 60
    property int hudBarWidth: 160

    property FileView _wal: FileView {
        path: Quickshell.env("HOME") + "/.cache/wal/colors.json"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            const data = JSON.parse(text());
            root.background = data.special.background;
            root.foreground = data.special.foreground;
            const c = data.colors;
            root.color0 = c.color0;
            root.color1 = c.color1;
            root.color2 = c.color2;
            root.color3 = c.color3;
            root.color4 = c.color4;
            root.color5 = c.color5;
            root.color6 = c.color6;
            root.color7 = c.color7;
            root.color8 = c.color8;
            root.color9 = c.color9;
            root.color10 = c.color10;
            root.color11 = c.color11;
            root.color12 = c.color12;
            root.color13 = c.color13;
            root.color14 = c.color14;
            root.color15 = c.color15;
        }
    }
}
