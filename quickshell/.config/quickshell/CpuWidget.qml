import QtQuick
import Quickshell
import Quickshell.Io

// CPU usage readout. Bare content only (icon + percentage) — it's placed
// inside the shared SystemGroup pill, so it doesn't draw its own BarModule.
Item {
    id: root

    property real usage: 0
    property var _prevIdle
    property var _prevTotal

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: cpuProc.running = true
    }

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -n1 /proc/stat"]

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(/\s+/).slice(1).map(Number);
                const idle = parts[3] + parts[4];
                const total = parts.reduce((a, b) => a + b, 0);
                if (root._prevTotal !== undefined) {
                    const totalDelta = total - root._prevTotal;
                    const idleDelta = idle - root._prevIdle;
                    if (totalDelta > 0)
                        root.usage = Math.round(100 * (1 - idleDelta / totalDelta));
                }
                root._prevIdle = idle;
                root._prevTotal = total;
            }
        }
    }

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconFontSize
            text: ""
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            text: root.usage + "%"
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["top"])
    }
}
