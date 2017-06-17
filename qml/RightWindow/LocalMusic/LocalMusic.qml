/*
  目前有个问题，就是每当点击“本地音乐”，改页面需要重新加载时，如果正在播放音乐，音乐会停止，还不知原因
  */

import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import "../../TitleBar"

Rectangle {
    property string dirPath:{
        var count=dirModel.count;
        var temp="";
        for(var i=0;i<count;++i)
        {
            temp+=dirModel.get(i).name;
            temp+=",";
        }
        return temp;
    }
    id:root;
    color:"#16181C";

    ListModel{
        id:dirModel;
    }

    FileDialog{
        id:fileDialog;
        title: qsTr("选择添加目录");
        folder: shortcuts.music;
        selectFolder: true;
        onAccepted: {
            //不能用fileDialog.folder直接赋值，会出错，不知原因，也不能
            //使用JS的String类的slice等函数
            var json=JSON.parse("{\"path\":\""+fileDialog.folder+"\"}");
            dirModel.append({
                            "name":json["path"]
                            })
        }
    }

    Popup{
        id:dirDialog;
        width: 300*dp;
        height: 250*dp;
        x:(parent.width-width)/2;
        y:(parent.height-height)/2;

        background: Rectangle{
            anchors.fill: parent;
            color: "#2D2F33";
            Label{
                text: qsTr("选择本地音乐文件夹");
                color: "white";
                font.family: "Microsoft YaHei";
                font.pixelSize: 16*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignHCenter;
                padding: 10*dp;
            }
            TitleBarBtn{
                anchors{
                    top:parent.top;
                    topMargin: 5*dp;
                    right: parent.right;
                    rightMargin: 5*dp;
                }
                btnWidth: 30*dp;
                btnHeight: 30*dp;
                btnText: "\uf4e6";
                fontSize: 18*dp;
                fontColor: "#828487";
                hovered_fontColor: "#dcdde4";
                toolTip: qsTr("关闭");
                backgroundColor: "#2D2F33";

                btnClicked: function(){
                    dirDialog.close();
                }
            }
            Rectangle{
                id:rect1;
                anchors.top: parent.top;
                anchors.topMargin: 40*dp;
                width: parent.width;
                height: 1*dp;
                color: "#3B3A3D";
            }


                Controls_1_4.ScrollView{
                    id:popUpFlickable;
                    anchors.top: rect1.bottom;
                    width: parent.width;
                    height: 200*dp;
                    horizontalScrollBarPolicy:Qt.ScrollBarAlwaysOff;



                    Column{
                        id:popUpColumn;
                        width: parent.width;

                        Repeater{
                            model: dirModel;
                            delegate: CheckBox{
                                id:control;
                                width: 300*dp;
                                text: name;
                                checked: true;
                                indicator: Rectangle{
                                    implicitWidth: 20*dp;
                                    implicitHeight: 20*dp;
                                    x: control.leftPadding
                                    y: parent.height / 2 - height / 2
                                    radius: 1*dp;
                                    color: "#2D2F33"
                                    border.color: "#414347";

                                    Label{
                                        anchors.centerIn: parent;
                                        text: "\uf747";
                                        color: "red";
                                        font.pixelSize: 16*dp;
                                        font.family:icomoonFont.name;
                                        visible: control.checked;
                                    }
                                }

                                contentItem: Text {
                                    property bool ishovered: false;
                                    text: name;
                                    color: "white";
                                    font.family: "Microsoft YaHei";
                                    font.pixelSize: 12*dp;
                                    horizontalAlignment: Text.AlignLeft;
                                    verticalAlignment: Text.AlignVCenter;
                                    leftPadding: control.indicator.width + control.spacing;
                                    elide:Text.ElideRight;

                                    ToolTip.visible: ishovered;
                                    ToolTip.delay: 500;
                                    ToolTip.text: name;

                                    MouseArea{
                                        anchors.fill: parent;
                                        hoverEnabled: true;

                                        onEntered: {
                                            parent.ishovered=true;
                                        }
                                        onExited: {
                                            parent.ishovered=false;
                                        }
                                        onClicked: {
                                            dirModel.remove(index,1);
                                        }
                                    }
                                }

                            }
                        }
                    }

                    style:ScrollViewStyle{
                        handle: Rectangle {
                            implicitWidth: 7*dp;
                            implicitHeight: 0;
                            color: "#16181C";
                            radius: 5*dp;
                            anchors.fill: parent;
                            anchors.top: parent.top;
                            //anchors.topMargin: -1*dp;
                            anchors.right: parent.right;

                        }
                        scrollBarBackground:Rectangle{
                            anchors.top: parent.top;
                            anchors.right: parent.right;
                            implicitWidth: 7*dp;
                            implicitHeight: 0
                            color: "#2F3134";
                        }
                        //可以使区域向上或者向右移动的区域和按钮
                        decrementControl: Rectangle {
                            implicitWidth: 0
                            implicitHeight: 0*dp
                        }
                        //可以使区域向下或者向左移动的区域和按钮
                        incrementControl: Rectangle {
                            implicitWidth: 0
                            implicitHeight: 0*dp
                        }

                    }
                }

            Rectangle{
                anchors.top: popUpFlickable.bottom;
                width: parent.width;
                height: 50*dp;
                color: "#292B2F";

                Button{
                    id:okBtn;
                    width: 70*dp;
                    height: 30*dp;
                    anchors{
                        left: parent.left;
                        leftMargin: 60*dp;
                        verticalCenter: parent.verticalCenter;
                    }
                    text: qsTr("确认");
                    font{
                        family: "Microsoft YaHei";
                        pixelSize: 12*dp;
                    }

                    contentItem: Text {
                        text: okBtn.text;
                        font: okBtn.font;
                        color: "white";
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle{
                        anchors.fill: parent;
                        radius: 3*dp;
                        color: "#2E4E7E";
                    }
                    onClicked: {
//                        var count=dirModel.count;
//                        for(var i=0;i<count;++i)
//                        {
//                            dirPath+=dirModel.get(i).name;
//                            dirPath+=",";
//                        }
                        dirDialog.close();
                        loader.setSource("qrc:/qml/RightWindow/LocalMusic/MusicList.qml",{"dirPath":dirPath});
                    }

                }
                Button{
                    id:selectedBtn;
                    width: 70*dp;
                    height: 30*dp;
                    anchors{
                        right: parent.right
                        rightMargin: 60*dp;
                        verticalCenter: parent.verticalCenter;
                    }
                    text: qsTr("添加文件夹");
                    font{
                        family: "Microsoft YaHei";
                        pixelSize: 10*dp;
                    }

                    contentItem: Text {
                        text: selectedBtn.text;
                        font: selectedBtn.font;
                        color: "white";
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle{
                        anchors.fill: parent;
                        radius: 3*dp;
                        color: "#37383C";
                    }
                    onClicked: {
                        fileDialog.open();
                    }

                }

            }


        }
    }

    Controls_1_4.ScrollView{
        id:localFlickable;
        width: parent.width;
        height: parent.height;
        horizontalScrollBarPolicy:Qt.ScrollBarAlwaysOff;

        Column{
            property var musicCount: function(count){
                musicCount.songCount=count;
            }

            id:rootColumn;
            width: root.width;
            spacing: 10*dp;

            Row{
                height: 50*dp;
                anchors.left: parent.left;
                anchors.leftMargin: 20*dp;
                spacing: 0;

                Label{
                    height: parent.height;
                    color: "white";
                    text: qsTr("本地音乐");
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 18*dp;
                    verticalAlignment: Label.AlignBottom;
                    rightPadding: 5*dp;
                }

                Label{
                    property int songCount:0;
                    id:musicCount;
                    height: parent.height;
                    color: "#adafb2";
                    text:songCount+qsTr("首音乐,");
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 12*dp;
                    verticalAlignment: Label.AlignBottom;
                }

                Label{
                    height: parent.height;
                    color: "#2e6bb0";
                    text: qsTr("选择目录");
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 12*dp;
                    verticalAlignment: Label.AlignBottom;

                    MouseArea{
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;

                        onClicked: {
                            dirDialog.open();
                        }
                    }
                }
            }

            Rectangle{
                width: parent.width;
                height: 1*dp;
                color: "#23262c";
            }

            Row{
                anchors.left: parent.left;
                anchors.leftMargin: 20*dp;
                width: parent.width-20*dp;
                height: 40*dp;

                Rectangle{
                    width: 80*dp;
                    height: 25*dp;
                    color: "#26272b";
                    radius: 5*dp;
                    anchors.verticalCenter: parent.verticalCenter;

                    Label{
                        width: 20*dp;
                        height: parent.height;
                        anchors.leftMargin: 5*dp;
                        text: "\ufe5d";
                        color: "white";
                        font.family: icomoonFont.name;
                        font.pixelSize: 14*dp;
                        verticalAlignment:Label.AlignVCenter;
                        horizontalAlignment: Label.AlignHCenter;
                    }
                    Label{
                        //width: 40*dp;
                        height: parent.height;
                        anchors.right: parent.right;
                        anchors.rightMargin: 5*dp;
                        text: qsTr("匹配音乐");
                        color: "white";
                        font.family: "Microsoft YaHei";
                        font.pixelSize: 12*dp;
                        verticalAlignment:Label.AlignVCenter;
                        horizontalAlignment: Label.AlignHCenter;
                    }

                    MouseArea{
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;

                        onClicked: {
                            loader.source="";
                            loader.setSource("qrc:/qml/RightWindow/LocalMusic/MusicList.qml",{"dirPath":dirPath});
                        }
                    }
                }
            }

            Loader{
                id:loader;
                width: parent.width;
                source: "qrc:/qml/RightWindow/LocalMusic/MusicList.qml";

                Component.onCompleted: {
                    loader.setSource("qrc:/qml/RightWindow/LocalMusic/MusicList.qml",{"dirPath":dirPath});
                }
            }
        }



        style:ScrollViewStyle{
            handle: Rectangle {
                implicitWidth: 7*dp;
                implicitHeight: 0;
                color: "#2F3134";
                radius: 5*dp;
                anchors.fill: parent;
                anchors.top: parent.top;
                //anchors.topMargin: -1*dp;
                anchors.right: parent.right;

            }
            scrollBarBackground:Rectangle{
                anchors.top: parent.top;
                anchors.right: parent.right;
                implicitWidth: 7*dp;
                implicitHeight: 0
                color: "#16181C"
            }
            //可以使区域向上或者向右移动的区域和按钮
            decrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0*dp
            }
            //可以使区域向下或者向左移动的区域和按钮
            incrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0*dp
            }

        }
    }
}
