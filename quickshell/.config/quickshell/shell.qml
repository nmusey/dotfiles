import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {
            required property var modelData
            screen: modelData
        }
    }

    Variants {
        model: Quickshell.screens

        HudWindow {
            required property var modelData
            screen: modelData
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
