import QtQuick 2.7
import QtQuick.Controls 2.1

Label{
    property string btnText: "";
    property bool isClicked: false;
    property int type: 0;
    property var clickedFunction:function(){};
    id:tab;
    width: 80*dp;
    height: 30*dp;
    text: btnText;
    font.family: "Microsoft YaHei";
    font.pixelSize: 12*dp;
    verticalAlignment: Text.AlignVCenter;
    horizontalAlignment: Text.AlignHCenter;
    color: "#ffffff";
    background: Rectangle{
        id:backRect;
        anchors.fill: parent;
        color: "#25272b";
    }

    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor;

        onEntered: {
            if(!isClicked)
                backRect.color="#2c2e32";
        }
        onExited: {
            if(!isClicked)
                backRect.color="#25272b";
        }
        onClicked: {
            if(!isClicked)
                clickedFunction();
            isClicked=true;
            backRect.color="#b82525";
            tab.parent.tabClicked(tab.objectName);           
        }
    }

    function reset(){
        backRect.color="#25272b";
        isClicked=false;
    }

    function firstClicked(){
        isClicked=true;
        backRect.color="#b82525";
        clickedFunction();
    }

    Component.onCompleted: {
        parent.btns.push(tab);
    }
}
