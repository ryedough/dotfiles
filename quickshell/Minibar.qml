// Bar A: full-width top bar, shown when the workspace has windows.
import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: root

    anchors { top: true; left: true; right: true }
    implicitHeight: 20
    color: "transparent"
        RowLayout {
            anchors.fill : parent

            SkewedRect {
                z : 2
                fill : "#00FF26"
                Layout.fillHeight : true
                Layout.preferredWidth : childrenRect.width
                skew.right : true
                Text {
                    leftPadding : 7
                    anchors.verticalCenter : parent.verticalCenter
                    text : Time.dayNow
                }
            }
            SkewedRect {
                z : 1
                fill : "#03BF2C"
                Layout.fillHeight : true
                Layout.preferredWidth : childrenRect.width
                skew.right : true
                Text {
                    leftPadding : 14
                    anchors.verticalCenter : parent.verticalCenter
                    text : Time.dateMonthNow
                }
            }
            SkewedRect {
                fill : "#394260"
                Layout.fillHeight : true
                Layout.preferredWidth : childrenRect.width
                skew.right : true
                Text {
                    leftPadding : 14
                    anchors.verticalCenter : parent.verticalCenter
                    text : Time.hourNow
                    color : "#00FF26"
                }
            }

            Item {
                width : 20
            }

            SkewedRect {
                z : 2
                fill : "#00FF26"
                Layout.fillHeight : true
                Layout.preferredWidth : childrenRect.width
                skew.right : true
                skew.left : true
                HoverHandler {
                    id : batHover
                }
                Image {
                    anchors.verticalCenter : parent.verticalCenter
                    height : 16
                    source: Qt.resolvedUrl("./icons/plug.png")
                    visible : Battery.status !== Battery.State.Discharging
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                }
                Image {
                    anchors.verticalCenter : parent.verticalCenter
                    height : 16
                    source: Qt.resolvedUrl("./icons/batFull.png")
                    visible : Battery.percentage > 90 && Battery.status === Battery.State.Discharging
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                }
                Image {
                    anchors.verticalCenter : parent.verticalCenter
                    height : 16
                    source: Qt.resolvedUrl("./icons/bat70.png")
                    fillMode: Image.PreserveAspectFit
                    visible : Battery.percentage >= 70 && Battery.percentage < 90 && Battery.status === Battery.State.Discharging
                    asynchronous: true
                }
                Image {
                    anchors.verticalCenter : parent.verticalCenter
                    height : 16
                    source: Qt.resolvedUrl("./icons/bat50.png")
                    visible : Battery.percentage >= 40 && Battery.percentage < 70 && Battery.percentage < 90 && Battery.status === Battery.State.Discharging
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                }

                Image {
                    anchors.verticalCenter : parent.verticalCenter
                    height : 16
                    source: Qt.resolvedUrl("./icons/bat30.png")
                    visible : Battery.percentage >= 20 && Battery.percentage < 40 && Battery.percentage < 90 && Battery.status === Battery.State.Discharging
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                }
                Image {
                    anchors.verticalCenter : parent.verticalCenter
                    height : 16
                    visible : Battery.percentage < 20 && Battery.percentage < 90 && Battery.status === Battery.State.Discharging
                    source: Qt.resolvedUrl("./icons/bat0.png")
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                }
            }

            SkewedRect {
                z : 1
                fill : "#03BF2C"
                Layout.fillHeight : true
                Layout.preferredWidth : childrenRect.width
                skew.right : true
                Text {
                    leftPadding : 14
                    anchors.verticalCenter : parent.verticalCenter
                    text : Battery.percentage
                }
            }

            SkewedRect {
                fill : "#394260"
                Layout.fillHeight : true
                Layout.preferredWidth : childrenRect.width
                skew.right : true
                visible : Battery.mode !== Battery.Unknown
                Text {
                    leftPadding : 14
                    anchors.verticalCenter : parent.verticalCenter
                    text : Battery.modeStr
                    color : "#00FF26"
                }
            }

            Item {
                Layout.fillWidth : true
            }
        }
    // Rectangle {
    //     anchors.fill : parent
    //     color: "#99000000"
    // }
}
