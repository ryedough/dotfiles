// Bar B: no bar, just floating items. Shown when the workspace is empty.
// Root is a Scope because it contains several separate windows.
import QtQuick
import Quickshell

Scope {
    id: root

    property var screen
    property date now: new Date()

    PanelWindow {
        screen: root.screen
        anchors.top: true
        margins.top: 16
        exclusionMode: ExclusionMode.Ignore
        implicitWidth: 180
        implicitHeight: 48
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 2
            color: "#cc1e1e2e"
            border.color: "#89b4fa"
            border.width: 1

            Text {
                anchors.centerIn: parent
                color: "#cdd6f4"
                font.pixelSize: 18
                text: Time.now
            }
        }
    }
}
