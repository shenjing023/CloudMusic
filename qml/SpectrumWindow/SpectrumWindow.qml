import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property string imageUrl;   //图片url
    property string title;          //音乐标题
    property string artists;        //歌手
    property var setMax1:function(){
        loader.setSource("qrc:/qml/SpectrumWindow/MaxWindow.qml");
    }
    id:spectrumWindow;

    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;
    }

    Loader{
        id:loader;
    }
    state: "mini";

    states: [
        State {
            name: "mini"
            PropertyChanges {
                target: spectrumWindow;
                width:200*dp;
                height:65*dp;
            }
        },
        State {
            name: "max"
            PropertyChanges {
                target: spectrumWindow;
                width:500*dp;
                height:500*dp;
            }
        }
    ]

    Behavior on width{
        PropertyAnimation {duration: 200}
    }
    Behavior on height{
        PropertyAnimation {duration: 200}
    }

    onStateChanged: {
        if(spectrumWindow.state=="mini")
            loader.setSource("qrc:/qml/SpectrumWindow/MiniWindow.qml",{"imageUrl":imageUrl,"title":title,"artists":artists});
        else
            loader.setSource("qrc:/qml/SpectrumWindow/MaxWindow.qml");
        console.log(spectrumWindow.state);
    }





    Component.onCompleted: {
        loader.setSource("qrc:/qml/SpectrumWindow/MiniWindow.qml",{"imageUrl":imageUrl,"title":title,"artists":artists});
    }
}
