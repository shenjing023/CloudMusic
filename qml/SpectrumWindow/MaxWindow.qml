import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property string album:maxWindow.parent.parent.album;   //图片url
    property string title:maxWindow.parent.parent.title;          //音乐标题
    property string artists:maxWindow.parent.parent.artists;        //歌手
    width: 998*dp;
    height: 575*dp;
    id:maxWindow;
    color: "#191b1f";

//    function updateInfo(_title,_album,_artists){
//        maxWindow.title=_title;
//        maxWindow.artists=_artists;
//        maxWindow.album=_album;
//    }

    //歌名
    Label{
        id:songName;
        anchors{
            horizontalCenter: parent.horizontalCenter;
            top:parent.top;
            topMargin: 20*dp;
        }
        text:title;
        font{
            family:"Microsoft YaHei";
            pixelSize: 20*dp;
        }
        color: "white";
    }

    Row{
        anchors{
            left: songName.left;
            top:songName.bottom;
            topMargin: 10*dp;
        }
        width: 300*dp;
        height: 30*dp;
        spacing: 5*dp;

        Label{
            text: qsTr("专辑:");
            font{
                family:"Microsoft YaHei";
                pixelSize: 12*dp;
            }
            color: "white";
        }

        Label{
            id:lab_Album;
            //width: 120*dp;
            height: parent.height;
            text: maxWindow.album;
            font{
                family:"Microsoft YaHei";
                pixelSize: 12*dp;
            }
            color: "#2d5789";
            elide:Text.ElideRight;

            Component.onCompleted: {
                if(lab_Album.width>120*dp)
                    lab_Album.width=120*dp;
            }
        }

        Label{
            text: qsTr("歌手:");
            font{
                family:"Microsoft YaHei";
                pixelSize: 12*dp;
            }
            color: "white";
        }

        Label{
            width: 100*dp;
            height: parent.height;
            text: maxWindow.artists;
            font{
                family:"Microsoft YaHei";
                pixelSize: 12*dp;
            }
            color: "#2d5789";
            elide:Text.ElideRight;
        }
    }

    Rectangle{
        anchors{
            top:parent.top;
            topMargin: 20*dp;
            right: parent.right;
            rightMargin: 20*dp;
        }

        width: 50*dp;
        height: 30*dp;
        color: "#222529";

        Label{
            anchors.fill: parent;
            color: "#686a6e";
            text: "\uec7a";
            font.family: icomoonFont.name;
            font.pixelSize: 20*dp;
            verticalAlignment:Label.AlignVCenter;
            horizontalAlignment: Label.AlignHCenter;

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: Qt.PointingHandCursor;

                onClicked: {
                    maxWindow.parent.parent.state="mini";
                }
            }
        }
    }

    Rectangle{
        property var pcmDatastr:AudioData.pcmData
        id:spectrum;
        width: parent.width;
        height: parent.height;
        color: "transparent";

        ListModel{
            id:dataModel
        }
        onPcmDatastrChanged: {
            try{
                if(dataModel.count===0)
                    return;
                var jdata=JSON.parse(pcmDatastr).data;
                for(var a=0;a<jdata.length;a++){
                    dataModel.setProperty(a,"pcmdata",jdata[a]);
                }

            }
            catch(e){
                console.log(e);
            }
        }
        Row{
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                model: dataModel
                delegate: Rectangle{
                    width: spectrum.width/dataModel.count
                    height: pcmdata*spectrum.height/255
                    color:Qt.rgba(index/257,Math.abs(257-index)/257,Math.abs(257-index)/257,1)
                    anchors.bottom: parent.bottom
                    //                radius: width/2
                    //                border.width:1
                    //                border.color:"#ffff12"
                    Rectangle{
                        width:parent.width
                        height:1
                        color:"#454545"
                    }

                    Behavior on height{
                        PropertyAnimation{
                            properties: "height";
                            duration: 100;
                        }
                    }
                }
            }
        }
        Component.onCompleted: {
            for(var a=0;a<257;a++){
                dataModel.append({"pcmdata":0});
            }
        }
    }

    Component.onCompleted: {

    }
}
