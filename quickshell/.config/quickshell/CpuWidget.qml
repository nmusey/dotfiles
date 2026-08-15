import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property real usage: 0
    property var _prevIdle
    property var _prevTotal

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

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

    BarModule {
        id: pill
        anchors.fill: parent

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconFontSize
            text: ""
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
        onClicked: Quickshell.execDetached(["top"])
    }
}
