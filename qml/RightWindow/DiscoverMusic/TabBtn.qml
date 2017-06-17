import QtQuick 2.7
import QtQuick.Controls 2.1

Label{
    property string btnText;
    property color color_hovered;
    property bool isClicked: false;
    property var btnClickFunc: (function(){});
    id:tab;
    Label{
        id:lab;
        width: parent.width;
        height: parent.height/1.1;
        text: btnText;
        font.family: "Microsoft YaHei";
        font.pixelSize: 16*dp;
        verticalAlignment: Text.AlignVCenter;
        horizontalAlignment: Text.AlignHCenter;
        color: "#828385";
    }

    Rectangle{
        id:rect;
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 2*dp;
        color: "#5C5E61";
        visible: false;
    }

    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor;

        onEntered: {
            if(!isClicked)
                lab.color=color_hovered;
        }

        onExited: {
            if(!isClicked)
                lab.color="#828385";
        }

        onClicked: {
            isClicked=true;
            rect.visible=true;
            tab.parent.tabClicked(tab.objectName);
            btnClickFunc();
        }
    }

    function reset(){
        lab.color="#828385";
        isClicked=false;
        rect.visible=false;
    }

    //设置为已点击状态
    function firstClicked(){
        isClicked=true;
        rect.visible=true;
        lab.color=color_hovered;
    }

    Component.onCompleted: {
        parent.btns.push(tab);
    }
}
