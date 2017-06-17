import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property string imageSource;    //图片url
    property string text_bottom;     //底部的text
    property string url;        //链接
    property int type;      //内容类型，目前所知，5是视频，19是网页
    width: 240*dp;
    height: 170*dp;
    color: "transparent";

    Image {
        id: image;
        width: parent.width;
        height: 130*dp;
        source: imageSource;

        Rectangle{
            anchors{
                left: parent.left;
                leftMargin: 5*dp;
                top:parent.top;
                topMargin: 5*dp;
            }
            width: 35*dp;
            height:35*dp;
            radius: 35*dp;
            color: "black";
            opacity: 0.5;
            border{
                color: "white";
                width: 1*dp;
            }

            Label{
                width: 18*dp;
                height: 18*dp;
                anchors.centerIn: parent;
                text:type===5?"\uf3ac":"\uf866";
                color: "#f5f4f2";
                font.pixelSize: 18*dp;
                font.family:icomoonFont.name;
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter;
            }
        }

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;
        }
    }

    Label{
        width: parent.width;
        height: 35*dp;
        anchors.top: image.bottom;
        anchors.topMargin: 5*dp;
        text: text_bottom;
        color: "#dcdde4";
        font.family: "Microsoft YaHei";
        font.pixelSize: 12*dp;
        wrapMode: Text.Wrap;
    }
}
