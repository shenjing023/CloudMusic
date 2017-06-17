import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    width: 768*dp;
    height: 325*dp;

    Label{
        id:label;
        anchors.centerIn: parent;
        text: "\ue92c";
        font.pixelSize: 80*dp;
        font.family:icomoonFont.name;
        color: "#828385";
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignHCenter;
    }
    Label{
        anchors.top: label.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: qsTr("开发中，敬请期待!");
        font.family: "Microsoft YaHei";
        font.pixelSize: 18*dp;
        color: "#828385";
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignHCenter;
    }
}
