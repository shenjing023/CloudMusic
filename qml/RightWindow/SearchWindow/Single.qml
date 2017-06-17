import QtQuick 2.7
import QtQuick.Controls 2.1
import Network 1.0

Rectangle{
    property string param;  //搜索的关键词
    id:root;
    //width: parent.width;
    height:column.height+26*dp;
    color: "transparent";

    Network{
        id:network;
        onSig_requestFinish: {
            var json=JSON.parse(bytes);
            root.parent.parent.searchInfo(json["result"]["songCount"],qsTr("首单曲"));
            var songs=json["result"]["songs"];
            songsModel.clear();
            var artists;    //歌手
            for(var i=0;i<songs.length;++i)
            {
                var artistsArray=[];artistsArray.length=0;
                for(var j=0;j<songs[i]["artists"].length;++j)
                    artistsArray.push(songs[i]["artists"][j].name);
                artists=artistsArray.join("/");
                songsModel.append({
                                  "_title":songs[i].name,
                                  "_artists":artists,
                                  "_album":songs[i].album.name,
                                  "_duration":songs[i].duration,
                                  "_param":root.param,
                                  "_song_id":songs[i].id
                                  })
            }
        }
    }

    ListModel{
        id:songsModel;
    }

    Row{
        width: parent.width;
        height: 25*dp;
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
            width: 60*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("操作");
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
            width: 30*dp;
            height: parent.height;
            padding: 5*dp;
            text: qsTr("时长");
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            color: "#828385";
        }

//        Rectangle{
//            width: 1*dp;
//            height: parent.height;
//            color: "#23262c";
//        }

//        Label{
//            width: 100*dp;
//            height: parent.height;
//            padding: 5*dp;
//            text: qsTr("热度");
//            font.family: "Microsoft YaHei";
//            font.pixelSize: 12*dp;
//            color: "#828385";
//        }
    }

    Rectangle{
        width: parent.width;
        height: 1*dp;
        anchors.top: parent.top;
        anchors.topMargin: 25*dp
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
            model: songsModel;
            delegate: SingleDelegate{
                _index:index+1;
                title:_title;
                artists: _artists;
                album:_album;
                duration: _duration;
                param: _param;
                song_id: _song_id;
            }
        }
    }

    Component.onCompleted: {
        var url="http://music.163.com/api/search/get/web?csrf_token=";
        var params="hlpretag=&hlposttag=&s="+param+"&type=1&offset=0&total=true&limit=100";
        network.getUrlResource(url,params);
    }
}
