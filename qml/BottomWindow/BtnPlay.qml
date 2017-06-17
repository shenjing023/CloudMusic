import QtQuick 2.7
import QtQuick.Controls 2.1

Label{
    property string btnText;
    property string toolTip;
    property bool ishovered: false;
    property var btnClicked: (function(){});

    width: 29*dp;
    height: 27*dp;
    anchors.verticalCenter: parent.verticalCenter;
    verticalAlignment:Label.AlignVCenter;
    horizontalAlignment: Label.AlignHCenter;

    ToolTip.visible: ishovered;
    ToolTip.delay: 500;
    ToolTip.text: toolTip;

    text: btnText;
    color: "#5a5a5c";
    font.pixelSize: 30*dp;
    font.family:icomoonFont.name;

    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor;

        onEntered: {
            parent.color="#fff";
            ishovered=true;
        }

        onExited: {
            parent.color="#5a5a5c";
            ishovered=false;
        }

        onClicked: {
            btnClicked();
        }
    }
}
