import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    width: parent.width;
    height: 500*dp;
    Label{
        id:lab;
        anchors.centerIn: parent;
        text: "\uf908";
        color: "#32343B";
        font.family: icomoonFont.name;
        font.pixelSize: 200*dp;
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignHCenter;
    }
    Label{
        anchors.top: lab.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: qsTr("网络不给力哦，请检查你的网络设置~");
        font.family: "Microsoft YaHei";
        font.pixelSize: 20*dp;
        color: "#828385";
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignHCenter;
    }
}
