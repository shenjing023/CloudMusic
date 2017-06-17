import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

import "TitleBar";
import "LeftWindow"
import "BottomWindow"
import "SpectrumWindow"

Window {
    property real dpScale: 1.5;     //在不同的分辨率屏幕下的窗口伸缩因子
    readonly property real dp: Math.max(Screen.pixelDensity*25.4/160*dpScale);
    id:mainWindow;
    color: "black";
    visible: true
    width: 1000*dp;
    height: 670*dp;
    flags: Qt.FramelessWindowHint | Qt.Window;

    //字体图标
    FontLoader{
        id:icomoonFont;
        source: "../font/icomoon.ttf";
    }

    /***********************************************************************
qml的加载顺序：从末尾处开始加载，是反过来的sdsadasdasdassfasfas
***********************************************************************/
    //标题栏
    TitleBar{
        id:titleBar;
        width: parent.width-2*dp;
        height: 45*dp;
        anchors.left: parent.left;
        anchors.leftMargin: 1*dp;
        anchors.top: parent.top;
        anchors.topMargin: 1*dp;
    }

    Rectangle{
        id:label1;
        color:"#b72525";
        width: parent.width-2*dp;
        height: 2*dp;
        anchors.left: parent.left;
        anchors.leftMargin: 1*dp;
        anchors.top: titleBar.bottom;
        }


    LeftWindow{
        id:leftWd;
        anchors.left: parent.left;
        anchors.leftMargin: 1*dp;
        anchors.top: label1.bottom;
        width: 200*dp;
        height: 575*dp;
        }


    BottomWindow{
        id:bottomWd;z:10
        anchors.left: parent.left;
        anchors.leftMargin: 1*dp;
        anchors.top: rightWd.bottom;
        width: parent.width-2*dp;
        height: 45*dp;
        }


    Loader{
        id:rightWd;
        width: 798*dp;
        height: 575*dp;
        anchors.left: leftWd.right;
        anchors.top: label1.bottom;
        source: "qrc:/qml/RightWindow/DiscoverMusic/DiscoverMusic.qml";
        }

    //跳转到各个界面，相当于路由
    function rightWdRouter(url,properties){
        rightWd.setSource(url,properties);
    }

    //播放网络音乐
    function playSong(song_id){
        bottomWd.play(song_id);
    }

    function setMusicInfo(){
        leftWd.height=520*dp;
    }

    function leftWdReset(){
        leftWd.allReset();
    }

    Component.onCompleted: {
        //var a=JSON.parse(AudioData.parseMusicInfo());console.log("list:",a["list"].length)
    }
}
