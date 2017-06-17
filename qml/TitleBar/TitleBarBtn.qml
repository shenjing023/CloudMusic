import QtQuick 2.7
import  QtQuick.Controls 2.1

Label{
    property var btnClicked: (function(){});   //点击时触发的事件函数
    property string btnText:"";             //按钮text
    property real btnWidth;                 //宽
    property real btnHeight;                //高
    property real fontSize;                   //字体大小
    property color fontColor;               //字体颜色
    property color hovered_fontColor;   //hover字体颜色
    property bool ishovered: false;        //是否hover状态
    property string toolTip;                    //tooltip
    property color backgroundColor:"white";
    id:btn;
    width: btnWidth;
    height: btnHeight;

    text: btnText;
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter;
    font.family:icomoonFont.name;
    font.pixelSize:fontSize;
    color: fontColor;
    background: Rectangle{
        anchors.fill: parent;
        color: backgroundColor;
    }

    ToolTip.visible: ishovered;
    ToolTip.delay: 500;
    ToolTip.text: toolTip;

    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor;

        onEntered: {
            btn.color=hovered_fontColor;
            ishovered=true;
        }

        onExited: {
            btn.color=fontColor;
            ishovered=false;
        }

        onClicked: {
            btnClicked();
        }
    }
}
