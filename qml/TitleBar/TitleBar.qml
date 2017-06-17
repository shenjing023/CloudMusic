/*
  标题栏
  */


import QtQuick 2.7
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0

import "../"

Rectangle{
    id:root;
    color: "#222225";


    MouseArea{
        property real xmouse;   //鼠标的x轴坐标
        property real ymouse;   //y轴坐标
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton; //只处理鼠标左键
        drag.filterChildren: true;

        onPressed: {
            xmouse=mouse.x;
            ymouse=mouse.y;
        }

        onPositionChanged: {
            mainWindow.x=mainWindow.x+(mouse.x-xmouse);
            mainWindow.y=mainWindow.y+(mouse.y-ymouse);
        }
    }

    // 程序图标
    Image{
        id:icon;
        source: "qrc:/images/logo.ico";
        width: 25*dp;
        height: 25*dp;
        anchors{
            left: parent.left;
            leftMargin: 10*dp;
            verticalCenter: parent.verticalCenter;
        }
    }

    //标题
    Label{
        id:title;
        anchors{
            left: icon.right;
            leftMargin: 2*dp;
            verticalCenter: parent.verticalCenter;
        }
        text: qsTr("<font color=\"white\">网易云音乐</font>");
        font{
            family: "Microsoft YaHei";
            pixelSize: 16*dp;
            bold: true;
        }
    }

    Rectangle{
        anchors.verticalCenter: parent.verticalCenter;
        width: 44*dp;
        height: 22*dp;
        anchors.left: title.right;
        anchors.leftMargin: 120*dp;
        color: "#17171a";
        radius: 1*dp;

        TitleBarBtn{
            id:backBtn;
            btnWidth: parent.width/2.0-1.5*dp;
            btnHeight: parent.height-2*dp;
            anchors{
                left: parent.left;
                leftMargin: 1*dp;
                verticalCenter: parent.verticalCenter;
            }
            btnText: "\uf74b";
            fontSize: 30*dp;
            fontColor: "#787879";
            hovered_fontColor: "#d2d2d3";
            toolTip: qsTr("后退");
            backgroundColor: "#212124";
            btnClicked: function(){
                console.log("backBtn clicked");
            }
        }

        TitleBarBtn{
            id:forwardBtn;
            anchors{
                right: parent.right;
                rightMargin: 1*dp;
                verticalCenter: parent.verticalCenter;
            }
            btnWidth: parent.width/2.0-1.5*dp;
            btnHeight: parent.height-2*dp;
            btnText: "\uf74c";
            fontSize: 30*dp;
            fontColor: "#787879";
            hovered_fontColor: "#d2d2d3";
            toolTip: qsTr("前进");
            backgroundColor: "#212124";
            btnClicked: function(){
                console.log("forwardBtn clicked");
            }
        }
    }



    //搜索栏
    Rectangle{
//        property Component searchDlg: null;
//        property var obj;
        id:searchBar;
        width: 230*dp;
        height: 23*dp;
        anchors{
            left: title.right;
            leftMargin: 180*dp;
            verticalCenter: parent.verticalCenter;
        }
        radius: 15*dp;
        color: "#151517";

        Controls_1_4.TextField{
            id:searchText;
            width: parent.width-40*dp;
            height: parent.height;
            anchors.left: parent.left;
            anchors.leftMargin: 10*dp;
            font.family: qsTr("宋体");
            font.pixelSize: 13*dp;
            verticalAlignment: TextInput.AlignVCenter;
            placeholderText: qsTr("搜索音乐，歌手，歌词，用户");
            textColor: "white";
            style: TextFieldStyle{
                placeholderTextColor: "#454546";
                background: Rectangle{
                    implicitWidth: searchText.width;
                    implicitHeight:searchText.height;
                    color: "#151517";
                }
            }

            Keys.enabled: true;
            Keys.onReturnPressed: {
                searchBtn.btnClicked();
            }

            onActiveFocusChanged: {
                if(activeFocus)
                {
                    if(text.length===0)
                        searchDlg.open();
                }
                else
                    searchDlg.close();
            }

            onTextChanged: {
                    if(text.length>0)
                        searchDlg.close();
                    else
                        searchDlg.open();
            }
        }

        TitleBarBtn{
            id:searchBtn;
            anchors.verticalCenter: parent.verticalCenter
            btnWidth: 18*dp;
            btnHeight: 18*dp;
            anchors.left: searchText.right;
            anchors.leftMargin: 3*dp;
            btnText: "\uea8b";
            fontSize: 12*dp;
            fontColor: "#787879";
            hovered_fontColor: "#c5c5c6";
            toolTip: qsTr("搜索");
            backgroundColor: "#151517";
            btnClicked: function(){
                searchText.focus=false;
                if(searchText.text.length>0)
                {
                    leftWdReset();
                    rightWdRouter("qrc:/qml/RightWindow/SearchWindow/SearchWindow.qml",{"params":searchText.text});
                }
            }
        }

        Popup{
            topMargin: searchBar.height+10*dp;
            id:searchDlg;
            visible: false;
            background: Loader{
                source: "qrc:/qml/TitleBar/SearchRect.qml";
            }
            //onClosed: searchText.focus=false;
        }

    }


    //最小化、关闭按钮
    Row{
        anchors.right: parent.right;
        anchors.rightMargin: 10*dp;
        height: parent.height;
        spacing: 3*dp;

        TitleBarBtn{
            id:miniBtn;
            anchors.verticalCenter: parent.verticalCenter
            btnWidth: 30*dp;
            btnHeight: 30*dp;
            btnText: "\uf4e4";
            fontSize: 18*dp;
            fontColor: "#828487";
            hovered_fontColor: "#dcdde4";
            toolTip: qsTr("最小化");
            backgroundColor: "#222225";

            btnClicked: function(){
                mainWindow.visibility=Window.Minimized;
            }
        }

        TitleBarBtn{
            id:closeBtn;
            anchors.verticalCenter: parent.verticalCenter
            btnWidth: 30*dp;
            btnHeight: 30*dp;
            btnText: "\uf4e6";
            fontSize: 18*dp;
            fontColor: "#828487";
            hovered_fontColor: "#dcdde4";
            toolTip: qsTr("关闭");
            backgroundColor: "#222225";

            btnClicked: function(){
                Qt.quit();
            }
        }
    }

}
