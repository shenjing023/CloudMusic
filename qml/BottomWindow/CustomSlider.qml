import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.1

Slider {
    property real minValue;
    property real maxValue;
    property bool isVisible: true;
    property bool ispressed: false;
    //property var releasedFunc: function(){}
    id: sliderControl;
    width: parent.width
    height: parent.height
    from: minValue;
    to:maxValue;

    background: Rectangle {
        x: sliderControl.leftPadding
        y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
        implicitWidth: sliderControl.width;
        implicitHeight: 5*dp;
        width: sliderControl.availableWidth
        height: implicitHeight
        radius: 3*dp;
        color: "#171719"

        Rectangle {
            width: sliderControl.visualPosition * parent.width
            height: parent.height
            color: "#b82525"
            radius: 3
        }
    }

    handle: Rectangle {
        visible: isVisible;
        x: sliderControl.leftPadding + sliderControl.visualPosition * (sliderControl.availableWidth - width)
        y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
        width: 15*dp;
        height: 15*dp;
        radius: 15*dp;//color: "blue"
        color: "#f6f6f6"

        Label{
            id:cd;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: "\uf6ca";
            color: "#b82525";
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter;
            font.family:icomoonFont.name;
            font.pixelSize: 20*dp;
        }

       // source: "qrc:/images/slider.png";

        MouseArea{
            property real xmouse;
            anchors.fill: parent;
            hoverEnabled: true;

            cursorShape: Qt.PointingHandCursor;
            acceptedButtons: Qt.LeftButton;
            onPressed: {
                xmouse=mouseX;
                sliderControl.ispressed=true;
            }

            onReleased: {
                sliderControl.ispressed=false;
                //sliderControl.releasedFunc();
            }

            onPositionChanged: {
                if(pressed)
                {
                    sliderControl.value=sliderControl.value+(mouseX-xmouse)/(sliderControl.width)*(maxValue-minValue);
                }
            }
        }
    }
}
