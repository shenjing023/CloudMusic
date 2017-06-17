import QtQuick 2.7
import QtQuick.Controls 2.1

SwitchDelegate{
    property string switchText;
    id:control;
    text:switchText;
    font{
        family: "Microsoft YaHei";
        pixelSize: 12*dp;
    }

    checked: false;

    onCheckedChanged: {
        switch(switchText)
        {
        case qsTr("回声"):
            AudioData.setEcho();
            break;
        case qsTr("EQ均衡器"):
            AudioData.setEq();
            break;
        case qsTr("消除人声"):
            AudioData.setCenterCut();
            break;
        case qsTr("混合立体声道"):
            AudioData.setMixChannels();
            break;
        }
    }

    contentItem: Text {
        rightPadding: control.indicator.width + control.spacing
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: "#cccccc"
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 26
        x: control.width - width - control.rightPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: control.checked ? "#17a81a" : "transparent"
        border.color: control.checked ? "#17a81a" : "#cccccc"

        Label{
            width: 24;
            height: 24;
            anchors.leftMargin: 13;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("开");
        }
        Label{
            width: 20;
            height: 24;
            anchors.right: parent.right;
            anchors.rightMargin: 3;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("关");
            color: "#cccccc";
        }

        Rectangle {
            x: control.checked ? parent.width - width : 0
            width: 26
            height: 26
            radius: 13
            color: control.down ? "#cccccc" : "#ffffff"
            border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
        }
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        visible: control.down || control.highlighted
        color: "transparent"
    } 

}

