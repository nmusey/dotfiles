pragma Singleton
import QtQuick

// Bridges the networking bubble-group icons (in the Bar) to the
// NetworkPopupWindow overlay they open. They live in independent top-level
// windows, so a singleton is the only shared state (same pattern as
// MprisHover). Closing is a plain click-toggle — no full-screen click-away
// catcher (see MediaExpandedWindow's note on why that's avoided).
QtObject {
    id: root

    // "" | "wifi" | "bluetooth" | "ethernet"
    property string panel: ""
    property var activeScreen: null

    function toggle(which, screen) {
        if (root.panel === which && root.activeScreen === screen) {
            root.close();
        } else {
            root.activeScreen = screen;
            root.panel = which;
        }
    }

    function close() {
        root.panel = "";
    }
}
