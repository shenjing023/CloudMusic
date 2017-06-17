import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Rectangle {
    property string imageSource;    //图片url
    property string text1;                  //鼠标hover是弹出的text
    property string text2;              //底部的text
    property string num;                  //顶部的听歌次数
    width: 139*dp;
    height: 170*dp;
    color: "transparent";

    Image {
        id: image;
        width: parent.width;
        height: 130*dp;
        source: imageSource;
        z:1;

        //顶部hover弹出区域
        Rectangle{
            id:text1Rect;
            width: parent.width;
            height: 50*dp;
            color: "black";
            opacity: 0.7;
            visible: false;
            z:2;

            Label{
                width: parent.width;
                height: parent.height;
                padding: 5*dp;
                text: text1;
                color: "#ffffff";
                font.family: "Microsoft YaHei";
                font.pixelSize: 12*dp;
                wrapMode: Text.Wrap;
                verticalAlignment: Text.AlignVCenter
            }
        }

        //顶部非hover区域
        Rectangle{
            id:numRect;
            width: parent.width;
            height: 20*dp;
            opacity: 0.7;
            color: "transparent";
            z:2;

            //颜色渐变
            LinearGradient{
                anchors.fill: parent;
                start: Qt.point(0, 0);
                end: Qt.point(parent.width, 0);
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 0.7; color: "gray" }
                    GradientStop { position: 1.0; color: "black" }
                }
            }

            Label{
                anchors.right: numLab.left;
                width: 30*dp;
                height: parent.height;
                text: "\uf82b";
                color: "white";
                font.pixelSize: 16*dp;
                font.family:icomoonFont.name;
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter;
            }

            Label{
                id:numLab;
                anchors.right: parent.right;
                width: 40*dp;
                height: parent.height;
                padding: 5*dp;
                text: (parseInt(num)>=100000)?parseInt(parseInt(num)/10000)+qsTr("万"):num;
                color: "white";
                font.family: "Microsoft YaHei";
                font.pixelSize: 12*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignRight;

                Component.onCompleted: {
                    switch(text.length)
                    {
                    case 3:
                        width=25*dp;
                        break;
                    case 4:
                        width=32*dp;
                        break;
                    case 5:
                        width=40*dp;
                        break;
                    default:
                        width=50*dp;
                        break;
                    }
                }
            }
        }

        //图像底部play按钮
        Label{
            id:playLab;
            width: 30*dp;
            height: 30*dp;
            anchors.bottom: parent.bottom;
            anchors.right: parent.right;
            text: "\ued03";
            color: "#e6e9ec"
            font.pixelSize: 24*dp;
            font.family:icomoonFont.name;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter;
            visible: false;

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: Qt.PointingHandCursor;

                onEntered: {

                }

                onExited: {

                }

                onClicked: {

                }
            }
        }

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;

            onEntered: {
                text1Rect.visible=true;
                numRect.visible=false;
                playLab.visible=true;
            }

            onExited: {
                text1Rect.visible=false;
                numRect.visible=true;
                playLab.visible=false;
            }

            onClicked: {

            }
        }
    }

    Label{
        width: parent.width;
        height: 35*dp;
        anchors.top: image.bottom;
        anchors.topMargin: 5*dp;
        text: text2;
        color: "#dcdde4";
        font.family: "Microsoft YaHei";
        font.pixelSize: 12*dp;
        wrapMode: Text.Wrap;
    }
}
