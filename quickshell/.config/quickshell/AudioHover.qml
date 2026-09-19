pragma Singleton
import QtQuick

// Shared state between the bar's VolumeWidget pill and the AudioPopupWindow
// overlay the output selector lives in. They're independent top-level windows
// with no common parent, so a singleton is the only way to bridge them (same
// pattern as MprisHover).
//
// Hover-only, deliberately: the pill's click already toggles mute, so unlike
// MprisHover there's no pinned state to click into. The grace timer is what
// lets the pointer hand off from the pill to the card without the card
// vanishing mid-travel.
QtObject {
    id: root

    property bool hovered: false
    property var activeScreen: null
    // Distance from the screen's right edge to the pill's right edge, so the
    // card can line up under the pill rather than the bar's corner. Reported
    // by the pill on hover (see VolumeWidget.rightInset).
    property int rightInset: 8

    property Timer hideTimer: Timer {
        interval: 250
        onTriggered: root.hovered = false
    }

    function preview(screen, inset) {
        activeScreen = screen;
        rightInset = inset;
        keepOpen();
    }

    // Re-assert an already-open card, for hover over the card itself: the pill
    // owns the screen and inset, so they are left alone here.
    function keepOpen() {
        hovered = true;
        hideTimer.stop();
    }

    function schedulePreviewHide() {
        hideTimer.restart();
    }
}
