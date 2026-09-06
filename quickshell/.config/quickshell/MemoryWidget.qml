import QtQuick
import Quickshell
import Quickshell.Io

// RAM usage readout. Bare content only (icon + percentage) — it's placed
// inside the shared SystemGroup pill, so it doesn't draw its own BarModule.
Item {
    id: root

    property real usage: 0

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: memProc.running = true
    }

    Process {
        id: memProc
        command: ["sh", "-c", "grep -E 'MemTotal|MemAvailable' /proc/meminfo"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                let total = 0;
                let avail = 0;
                for (const line of lines) {
                    const parts = line.trim().split(/\s+/);
                    if (parts[0].startsWith("MemTotal"))
                        total = Number(parts[1]);
                    if (parts[0].startsWith("MemAvailable"))
                        avail = Number(parts[1]);
                }
                if (total > 0)
                    root.usage = Math.round(100 * (1 - avail / total));
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
        onClicked: Quickshell.execDetached(["top", "-o", "+%MEM"])
    }
}
