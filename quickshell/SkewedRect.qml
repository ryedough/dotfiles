import Quickshell
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
    id: seg

    component Skew : QtObject {
        property bool right : false
        property bool left : false
        property real size : 10

        readonly property real rightSkewSize : {
            right ? size : 0
        }
        readonly property real leftSkewSize : {
            left ? size : 0
        }
    }

    property Skew skew : Skew{}

    property color fill: "#FFFFFF"

    default property alias child : childContainer.data

    Item {
        implicitWidth : childContainer.implicitWidth + seg.skew.leftSkewSize
        height : seg.height
        Shape {
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer

            ShapePath {
                id : skewer
                readonly property real rightSkewAddition : {
                    seg.skew.right ? 6 : 0
                }
                fillColor: seg.fill
                strokeColor: "transparent"
                strokeWidth: 0

                startX: 0;                       startY: 0
                PathLine { x: seg.Layout.preferredWidth + skewer.rightSkewAddition;          y: 0 }
                PathLine { x: seg.Layout.preferredWidth + seg.skew.rightSkewSize + skewer.rightSkewAddition; y: seg.height }
                PathLine { x: seg.skew.leftSkewSize;          y: seg.height }
                PathLine { x: 0;                 y: 0 }
            }
        }

        Item {
            id : childContainer
            anchors.left : parent.left
            anchors.leftMargin : seg.skew.leftSkewSize + (seg.skew.left && seg.skew.right ? 3 : 0)
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight : parent.implicitHeight
            implicitWidth : childrenRect.width
        }
    }

}
