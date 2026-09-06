import QtQuick

// The system-stats "bubble group": one visible pill holding the CPU and RAM
// usage readouts together.
Item {
    id: root

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    BarModule {
        id: pill
        anchors.fill: parent

        Row {
            spacing: 14

            CpuWidget {}
            MemoryWidget {}
        }
    }
}
