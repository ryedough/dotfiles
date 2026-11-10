// Picks Bar A or Bar B per monitor depending on whether the
// active Hyprland workspace has any windows.
//
// Files (keep in the same folder):  shell.qml  BarA.qml  BarB.qml
// Run:  quickshell -p shell.qml     (or ~/.config/quickshell/shell.qml)

pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland

ShellRoot {
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name.startsWith("activespecial"))
                Hyprland.refreshMonitors();
        }
    }

    Variants {
        model: Quickshell.screens

        Scope {
            id: scope
            required property var modelData

            readonly property var monitor: Hyprland.monitorFor(modelData)
            readonly property var workspace: monitor ? monitor.activeWorkspace : null
            readonly property string workspaceName: workspace ? workspace.name : "?"
            readonly property int windowCount: workspace ? workspace.toplevels.values.length : 0
            readonly property bool occupied: windowCount > 0

            // True while a special (scratchpad) workspace is shown on this monitor
            readonly property bool inSpecial: {
                const sw = monitor && monitor.lastIpcObject
                    ? monitor.lastIpcObject.specialWorkspace : null;
                return !!sw && sw.name !== "";
            }

            LazyLoader {
                active: !scope.inSpecial && scope.occupied

                Minibar {
                    screen: scope.modelData
                }
            }

            LazyLoader {
                active: !scope.inSpecial && !scope.occupied

                Fullbar {
                    screen: scope.modelData
                }
            }
        }
    }
}
