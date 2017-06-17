import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    width: 768*dp;
    height: 325*dp;

    BusyIndicator{
        id:busyIndicator
        anchors.centerIn: parent;
        running: true;
    }
    Label{
        anchors.top: busyIndicator.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: qsTr("载入中");
        font.family: "Microsoft YaHei";
        font.pixelSize: 18*dp;
        color: "#828385";
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignHCenter;
    }
}
