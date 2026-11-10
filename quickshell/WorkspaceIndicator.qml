// WorkspaceIndicator.qml
// Shows Hyprland workspaces and whether each one has a program (window) in it.
//
//   empty workspace    -> small dim dot
//   occupied workspace -> filled dot
//   active workspace   -> wide accent pill
//   urgent workspace   -> red dot
//
// Usage (e.g. inside a PanelWindow):
//   WorkspaceIndicator { count: 9 }

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root

    // Number of workspaces to always display (1..count)
    property int count: 10

    // Colors
    property color emptyColor: "#45475a"
    property color occupiedColor: "#cdd6f4"
    property color activeColor: "#89b4fa"
    property color urgentColor: "#f38ba8"

    // Sizes
    property int dotSize: 10
    property int activeWidth: 24
    property int spacing: 8

    implicitWidth: row.implicitWidth
    implicitHeight: dotSize + 8

    // Keep the window list fresh when windows open/close/move
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            const n = event.name;
            if (n === "openwindow" || n === "closewindow" || n === "movewindow"
                    || n === "movewindowv2" || n === "windowtitle") {
                Hyprland.refreshToplevels();
                Hyprland.refreshWorkspaces();
            }
        }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: root.spacing

        Repeater {
            model: root.count

            delegate: Rectangle {
                id: dot

                required property int index
                readonly property int wsId: index + 1

                // Look up the Hyprland workspace object (undefined if it doesn't exist yet)
                readonly property var ws: Hyprland.workspaces.values.find(w => w.id === wsId)

                readonly property bool isActive: Hyprland.focusedWorkspace !== null
                    && Hyprland.focusedWorkspace.id === wsId
                readonly property bool isUrgent: ws !== undefined && ws.urgent
                // A workspace has a program if its toplevel list is non-empty
                readonly property bool hasWindows: ws !== undefined
                    && ws.toplevels.values.length > 0

                Layout.preferredWidth: isActive ? root.activeWidth : root.dotSize
                Layout.preferredHeight: root.dotSize
                radius: height / 2

                color: isUrgent ? root.urgentColor
                     : isActive ? root.activeColor
                     : hasWindows ? root.occupiedColor
                     : root.emptyColor

                // Hollow look for empty, inactive workspaces
                border.width: (!hasWindows && !isActive && !isUrgent) ? 1 : 0
                border.color: root.emptyColor
                opacity: (hasWindows || isActive || isUrgent) ? 1.0 : 0.5

                Behavior on Layout.preferredWidth {
                    NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                }
                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on opacity { NumberAnimation { duration: 150 } }

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Hyprland.dispatch("workspace " + dot.wsId)
                }
            }
        }
    }
}
