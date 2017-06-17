import QtQuick 2.7
import  QtQuick.Controls 2.1

MouseArea {
    property int _cursorShape:Qt.PointingHandCursor;
    property var _onEnteredFunction: function(){};
    property var _onExitedFunction: function(){};
    property var _onClickedFunction: function(){};
    property string toolTip: "";
    //property bool isClicked: false;
    property bool ishovered: false;
    property bool isToolTip: true;  //是否有tooptip

    anchors.fill: parent;
    hoverEnabled: true;
    cursorShape:_cursorShape;

    ToolTip.visible: ishovered;
    ToolTip.delay: 500;
    ToolTip.text: toolTip;

    onEntered: {
        _onEnteredFunction();
        if(isToolTip)
            ishovered=true;
    }

    onExited: {
        _onExitedFunction();
        if(isToolTip)
            ishovered=false;
    }

    onClicked: {
        _onClickedFunction();

    }
}
