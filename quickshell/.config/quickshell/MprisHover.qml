pragma Singleton
import QtQuick

// Shared state between the bar's MprisWidget pill and the MediaExpandedWindow
// overlay it lives in a separate top-level window on. A singleton is the
// only way to bridge them, since they're independent windows with no shared
// parent.
QtObject {
    id: root

    // Transient: true while the pointer is over the pill or the card.
    property bool hovered: false
    // Sticky: true once the pill has been clicked; stays open regardless of
    // hover until it's clicked again (see MprisWidget's onClicked, which
    // calls close() to toggle it back off).
    property bool pinned: false
    property var activeScreen: null

    property Timer hideTimer: Timer {
        interval: 250
        onTriggered: {
            if (!root.pinned)
                root.hovered = false;
        }
    }

    function preview(screen) {
        activeScreen = screen;
        hovered = true;
        hideTimer.stop();
    }

    function schedulePreviewHide() {
        hideTimer.restart();
    }

    function pin(screen) {
        activeScreen = screen;
        pinned = true;
        hovered = true;
        hideTimer.stop();
    }

    function close() {
        pinned = false;
        hovered = false;
        hideTimer.stop();
    }
}
