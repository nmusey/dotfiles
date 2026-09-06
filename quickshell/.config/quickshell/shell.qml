import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {
            required property var modelData
            screen: modelData
        }
    }

    HudWindow {
        screen: {
            const screens = Quickshell.screens;
            for (const s of screens)
                if (s.name === "DP-2")
                    return s;
            return screens[0] ?? null;
        }
    }

    Variants {
        model: Quickshell.screens

        MediaExpandedWindow {
            required property var modelData
            screen: modelData
        }
    }

    Variants {
        model: Quickshell.screens

        NetworkPopupWindow {
            required property var modelData
            screen: modelData
        }
    }
}
