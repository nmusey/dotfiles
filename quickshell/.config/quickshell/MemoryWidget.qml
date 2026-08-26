import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property real usage: 0

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

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

    BarModule {
        id: pill
        anchors.fill: parent

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconFontSize
            text: ""
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
        anchors.fill: pill
        onClicked: Quickshell.execDetached(["top", "-o", "+%MEM"])
    }
}
