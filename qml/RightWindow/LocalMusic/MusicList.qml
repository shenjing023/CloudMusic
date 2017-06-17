import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property var dirPath;
    id:root;
    height:column.height+27*dp;
    color: "transparent";

    ListModel{
        id:songsModel;
    }

    Rectangle{
        width: parent.width;
        height: 1*dp;
        color: "#23262c";
    }

    Row{
        id:row;
        width: parent.width;
        height: 25*dp;
        anchors.top: parent.top;
        anchors.topMargin: 1*dp;
        spacing: 0;

        Rectangle{
            width: 60*dp;
            height: parent.height;
            color: "transparent";
        }

        Rectangle{
            width: 1*dp;
            height: parent.height;
            color: "#23262c";
        }

        Label{
            width: 250*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("音乐标题");
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            color: "#828385";
        }

        Rectangle{
            width: 1*dp;
            height: parent.height;
            color: "#23262c";
        }

        Label{
            width: 130*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("歌手");
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            color: "#828385";
        }

        Rectangle{
            width: 1*dp;
            height: parent.height;
            color: "#23262c";
        }

        Label{
            width: 180*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("专辑");
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            color: "#828385";
        }

        Rectangle{
            width: 1*dp;
            height: parent.height;
            color: "#23262c";
        }

        Label{
            width: 70*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("时长");
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            color: "#828385";
        }

        Rectangle{
            width: 1*dp;
            height: parent.height;
            color: "#23262c";
        }

        Label{
            width: 70*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("大小");
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            color: "#828385";
        }
    }

    Rectangle{
        width: parent.width;
        height: 1*dp;
        anchors.top: row.bottom;
        color: "#23262c";
    }

    Column{
        id:column;
        width: parent.width;
        anchors.top: parent.top;
        anchors.topMargin: 26*dp;

        property var items: new Array();
        function itemClicked(index){
            for(var i=0;i<items.length;++i)
            {
                if(index!==items[i]._index)
                    items[i].reset();
            }
        }

        Repeater{
            model:songsModel;
            delegate: MusicListDelegate{
                _index:index+1;
                title: _title;
                artists: _artists;
                album: _album;
                duration: _duration;
                size:_size;
                path:_path;
            }
        }
    }

    Component.onCompleted: {
        var json=JSON.parse(AudioData.parseMusicInfo(dirPath));
        var list=json["list"];
        root.parent.parent.musicCount(list.length);
        songsModel.clear();
        for(var i=0;i<list.length;++i)
        {
            songsModel.append({
                              "_title":list[i].title,
                                  "_artists":list[i].artists,
                                  "_album":list[i].album,
                                  "_duration":list[i].duration,
                                  "_size":list[i].size,
                                  "_path":list[i].path
                              })
        }
    }
}
