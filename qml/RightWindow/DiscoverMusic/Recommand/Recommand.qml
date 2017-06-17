import QtQuick 2.7
import QtQuick.Controls 2.1
import Network 1.0

Item {
    id:item;
    width: 758*dp;
    height: 325*dp;

    Loader{
        id:loader;
        anchors.centerIn: parent;
        source: "qrc:/qml/RightWindow/DiscoverMusic/Loading.qml";
    }

    Network{
        id:network;
        onSig_requestFinish: {
            //目前还没有处理网络连接不上的情况，都是按网络理想的情况来处理
            var json = JSON.parse(bytes);
            //顶部图片
            var banners=json["/api/v2/banner/get"]["banners"];
            viewModel.clear();
            for(var i=0;i<banners.length;++i)
            {
                viewModel.append({"url":banners[i].url,"imageUrl":banners[i].imageUrl});
            }
            //推荐歌单
            var playlist=json["/api/personalized/playlist"]["result"];
            songListModel.clear();
            for(i=0;i<playlist.length;++i)
            {
                songListModel.append({
                                     "_imageSource":playlist[i].picUrl,
                                     "_text1":playlist[i].copywriter,
                                     "_text2":playlist[i].name,
                                     "_num":playlist[i].playCount
                                     })
            }
            //独家放送
            var privatecontent=json["/api/personalized/privatecontent"]["result"];
            privateContentModel.clear();
            for(i=0;i<privatecontent.length;++i)
            {
                privateContentModel.append({
                                           "_imageSource":privatecontent[i].sPicUrl,
                                           "_text_bottom":privatecontent[i].name,
                                           "_url":privatecontent[i].url,
                                           "_type":privatecontent[i].type
                                           })
            }
            //最新音乐
            var newsong=json["/api/personalized/newsong"]["result"];
            newSongModel.clear();
            var name1,name2,artists,isSQ,isMV,imageSource,mp3Url;
            for(i=0;i<newsong.length;++i)
            {
                name1=newsong[i]["song"].name;  //主名
                name2="";   //副名
                if(newsong[i]["song"]["alias"].length>0)
                    name2=newsong[i]["song"]["alias"][0];
                var artistsTmp=[];artistsTmp.length=0;  //歌手数组
                for(var j=0;j<newsong[i]["song"]["artists"].length;++j)
                {
                    artistsTmp.push(newsong[i]["song"]["artists"][j].name);
                }
                artists=artistsTmp.join("/");
                imageSource=newsong[i]["song"]["album"].picUrl;
                isSQ=newsong[i]["song"]["copyright"]>0?true:false;
                isMV=newsong[i]["song"]["mvid"]>0?true:false;
                mp3Url=newsong[i]["song"]["mp3Url"];
                newSongModel.append({
                                    "_name1":name1,
                                        "_name2":name2,
                                        "_artists":artists,
                                        "_isSQ":isSQ,
                                        "_isMV":isMV,
                                        "_imageSource":imageSource,
                                        "_mp3Url":mp3Url
                                    })
            }

            loader.source="";
            root.visible=true;
            item.height=1270*dp;
        }
    }

    Rectangle{
       id:root;
       color: "transparent";
       width: parent.width;
       height: parent.height;
       visible: false;

        //个性推荐的顶部，使用pathView
        Rectangle{
            id:pathViewRect;
            width: root.width;
            height: 200*dp;
            anchors.left: parent.left;
            anchors.top: parent.top;
            color: "transparent";

            ListModel{
                id:viewModel;
//                ListElement{icon:"qrc:/images/ABC23.png"}
//                ListElement{icon:"qrc:/images/ABC23.png"}
//                ListElement{icon:"qrc:/images/ABC23.png"}
//                ListElement{icon:"qrc:/images/ABC23.png"}
//                ListElement{icon:"qrc:/images/ABC23.png"}
            }

            Component{
                id:viewDelegate;
                Item{
                    id:wrapper;
                    width: parent.width/1.5;
                    height: parent.height-20*dp;
                    anchors.top: parent.top;
                    anchors.topMargin: 10*dp;
                    z:PathView.zOrder;
                    scale: PathView.itemScale;
                    Image {
                        id:image;
                        anchors.fill: parent;
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: imageUrl;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;

                        onClicked: {
                            if(index!==pathView.currentIndex)
                            {
                                pathView.currentIndex=index;
                                pageIndicator.currentIndex=index;
                            }
                            else
                            {
                                //打开链接
                            }
                        }
                    }
                }
            }

            PathView{
                id:pathView;
                anchors.fill: parent;
                interactive: true;
                currentIndex: pageIndicator.currentIndex;
                pathItemCount: 3;
                preferredHighlightBegin: 0.5;
                preferredHighlightEnd: 0.5;
                highlightRangeMode: PathView.StrictlyEnforceRange;

                delegate: viewDelegate;
                model: viewModel;

                path:Path{
                    startX:50*dp;
                    startY:0*dp;
                    PathAttribute{name:"zOrder";value:0}
                    PathAttribute{name:"itemScale";value:0.2}
                    PathLine{
                        x:pathView.width/4;
                        y:0*dp;
                    }
                    PathAttribute{name:"zOrder";value:5}
                    PathAttribute{name:"itemScale";value:0.5}
                    PathLine{
                        x:pathView.width/2;
                        y:0*dp;
                    }
                    PathAttribute{name:"zOrder";value:10}
                    PathAttribute{name:"itemScale";value:1}
                    PathLine{
                        x:pathView.width*0.75;
                        y:0*dp;
                    }
                    PathAttribute{name:"zOrder";value:5}
                    PathAttribute{name:"itemScale";value:0.5}
                    PathLine{
                        x:pathView.width-50*dp;
                        y:0;
                    }
                    PathAttribute{name:"zOrder";value:0}
                    PathAttribute{name:"itemScale";value:0.2}
                }
            }

            PageIndicator{
                id:pageIndicator;
                interactive: true;
                count:pathView.count;
                currentIndex: pathView.currentIndex;
                height: 7*dp;
                anchors.bottom: parent.bottom;
                anchors.horizontalCenter: parent.horizontalCenter;
                delegate: Rectangle{
                    implicitWidth: 20*dp;
                    implicitHeight: 2*dp;
                    color: "#7F8082";
                    opacity: index === pageIndicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 500
                        }
                    }

                }

                onCurrentIndexChanged: {
                    timer.running=false;
                    timer.running=true;
                }
            }

            //Timer
            Timer{
                id:timer;
                interval: 7500;
                repeat: true;
                running: false;
                onTriggered: {
                    pageIndicator.currentIndex=(pageIndicator.currentIndex+1)%(pathView.count);
                }
            }

            Component.onCompleted: {
                timer.running=true;
            }
        }

        //推荐歌单
        Rectangle{
            id:songListRect;
            width: parent.width;
            height: 20*dp;
            color: "transparent";
            anchors.top: pathViewRect.bottom;
            anchors.topMargin: 20*dp;

            Label{
                width: 50*dp;
                height: parent.height;
                color: "#9fa0a7";
                text: qsTr("推荐歌单");
                font.family: "Microsoft YaHei";
                font.pixelSize: 20*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignLeft;
            }

            Label{
                width: 50*dp;
                height: parent.height;
                anchors.right: parent.right;
                color: "#828385";
                text: qsTr("更多>");
                font.family: "Microsoft YaHei";
                font.pixelSize: 14*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignRight;

                MouseArea{
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;

                    onClicked: {

                    }
                }
            }
        }

        Rectangle{
            id:rect;
            width: parent.width;
            height: 2*dp;
            anchors.top: songListRect.bottom;
            anchors.topMargin: 10*dp;
            color: "#202226";
        }


        ListModel{
            id:songListModel;

        }

        Grid{
            id:songPlayGrid;
            anchors.top: rect.bottom;
            anchors.topMargin: 10*dp;
            columns: 5;
            rows:2;
            spacing: 15*dp;
            horizontalItemAlignment: Grid.AlignHCenter;
            verticalItemAlignment: Grid.AlignVCenter;

            Rectangle{
                property string today:{
                    var today = new Date();
                    var d = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
                    return d[today.getDay()];
                }
                property string day:{
                    var today = new Date();
                    return today.getDate();
                }

                id:todayRect;
                width: 139*dp;
                height: 170*dp;
                color: "transparent";

                Rectangle{
                    width: parent.width;
                    height: 130*dp;
                    color: "white";

                    Rectangle{
                        id:text1Rect;
                        width: parent.width;
                        height: 50*dp;
                        color: "black";
                        opacity: 0.7;
                        visible: false;
                        z:1;

                        Label{
                            width: parent.width;
                            height: parent.height;
                            padding: 5*dp;
                            text: qsTr("根据您的音乐口味生成每日更新");
                            color: "#ffffff";
                            font.family: "Microsoft YaHei";
                            font.pixelSize: 12*dp;
                            wrapMode: Text.Wrap;
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Label{
                        width: parent.width;
                        height: 50*dp;
                        padding: 5*dp;
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter;
                        text: todayRect.today;
                        color: "#99999b";
                        font.family: "Microsoft YaHei";
                        font.pixelSize: 14*dp;
                        z:0;
                    }
                    Label{
                        width: parent.width;
                        height: 100*dp;
                        anchors.bottom: parent.bottom;
                        verticalAlignment: Text.AlignTop;
                        horizontalAlignment: Text.AlignHCenter;
                        text: todayRect.day;
                        color: "#B82525";
                        font.family: "Microsoft YaHei";
                        font.pixelSize: 70*dp;

                    }

                    MouseArea{
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;

                        onEntered: {
                            text1Rect.visible=true;
                        }

                        onExited: {
                            text1Rect.visible=false;
                        }

                        onClicked: {

                        }
                    }
                }

                Label{
                    width: parent.width;
                    height: 35*dp;
                    anchors.bottom: parent.bottom;
                    text: qsTr("每日歌曲推荐");
                    color: "#dcdde4";
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 12*dp;
                    wrapMode: Text.Wrap;
                }
            }

            Repeater{
                model: songListModel;
                delegate: SongListItem{
                    imageSource: _imageSource;
                    text1:_text1;
                    text2:_text2;
                    num:_num;
                }
            }
        }

        //独家放送
        Rectangle{
            id:privateContentRect;
            width: parent.width;
            height: 20*dp;
            color: "transparent";
            anchors.top: songPlayGrid.bottom;
            anchors.topMargin: 40*dp;

            Label{
                width: 50*dp;
                height: parent.height;
                color: "#9fa0a7";
                text: qsTr("独家放送");
                font.family: "Microsoft YaHei";
                font.pixelSize: 20*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignLeft;
            }

            Label{
                width: 50*dp;
                height: parent.height;
                anchors.right: parent.right;
                color: "#828385";
                text: qsTr("更多>");
                font.family: "Microsoft YaHei";
                font.pixelSize: 14*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignRight;

                MouseArea{
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;

                    onClicked: {

                    }
                }
            }
        }

        Rectangle{
            id:rect2;
            width: parent.width;
            height: 2*dp;
            anchors.top: privateContentRect.bottom;
            anchors.topMargin: 10*dp;
            color: "#202226";
        }

        ListModel{
            id:privateContentModel;

        }

        Row{
            id:privateContentRow;
            anchors.top: rect2.bottom;
            anchors.topMargin: 10*dp;
            spacing: 17*dp;

            Repeater{
                model: privateContentModel;
                delegate: PrivateContentItem{
                    imageSource:_imageSource;
                    text_bottom: _text_bottom;
                    url:_url;
                    type: _type;
                }
            }
        }

        //最新音乐
        Rectangle{
            id:newSongRect;
            width: parent.width;
            height: 20*dp;
            color: "transparent";
            anchors.top: privateContentRow.bottom;
            anchors.topMargin: 40*dp;

            Label{
                width: 50*dp;
                height: parent.height;
                color: "#9fa0a7";
                text: qsTr("最新音乐");
                font.family: "Microsoft YaHei";
                font.pixelSize: 20*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignLeft;
            }

            Label{
                width: 50*dp;
                height: parent.height;
                anchors.right: parent.right;
                color: "#828385";
                text: qsTr("更多>");
                font.family: "Microsoft YaHei";
                font.pixelSize: 14*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignRight;

                MouseArea{
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;

                    onClicked: {

                    }
                }
            }
        }

        Rectangle{
            id:rect3;
            width: parent.width;
            height: 2*dp;
            anchors.top: newSongRect.bottom;
            anchors.topMargin: 10*dp;
            color: "#202226";
        }

        Rectangle{
            id:newSong;
            anchors.top: rect3.bottom;
            anchors.topMargin: 10*dp
            width: parent.width;
            height: 302*dp;
            color: "transparent";
            border{
                width: 1*dp;
                color: "#202226";
            }

            Rectangle{
                width: 1*dp;
                height: parent.height;
                color: "#202226";
                anchors.centerIn: parent;
                z:3;
            }

            ListModel{
                id:newSongModel;
            }

            Grid{
                id:newSongGrid;
                width: parent.width-2*dp;
                anchors{
                    left: parent.left;
                    leftMargin: 1*dp;
                    top:parent.top;
                    topMargin: 1*dp;
                }

                columns: 2;
                rows:5;
                horizontalItemAlignment: Grid.AlignHCenter;
                verticalItemAlignment: Grid.AlignVCenter;
                property var items: new Array();
                function itemClicked(index){
                    for(var i=0;i<items.length;++i)
                    {
                        if(index!==items[i]._index)
                            items[i].reset();
                    }
                }
                Repeater{
                    model: newSongModel;
                    delegate: NewSongItem{
                        _index:index+1;
                        name1:_name1;
                        name2:_name2;
                        artists: _artists;
                        isSQ: _isSQ;
                        isMV: _isMV;
                        imageSource: _imageSource;
                        mp3Url: _mp3Url;
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        var url="http://music.163.com/eapi/batch";
        var params="0BD8BB39A78692F1744DEFF63EBC30F7FE83CBFBE69FB6E2A494DDC656FCF324992EBC760DFDA29344AB022F1ED1E1AD7F69DF3F9037CDA722EF9C5EC883D149A60E23D0330460A4BE0FE549BBCDFE7621739B66CD0E0C0CCF8405F6AF3F3F103B303EFD0B9AC5E24499ABF75580E51A266873D4ECB04E5BDF0EE5817CBFEFB0203BD3D6ED41272AD353B43D033004929DCACAF754EDC3D1C9DF5720E7389D3FA60E23D0330460A4BE0FE549BBCDFE76207E1DEDCAE9968287C2A3EE7CE1430BA7E74D4B82FE41EC4CCD5ADD46104647B777508B9E46A6831F34F1FE96D4C9CF403A65DC2326932CA692485D7D468112A0E5947E5B721259718EC12B285D54542E50169890D7AB95256E11B944BD4BB88F83E2028B47A3AF99821E6A87AAD0855D08C3EC33AD4C86E3200B98C5E15B787E6ED4DCD758B2C4F348D0571D1BC0FB968487627FC8A7A91D7A1BD818500AB657E2DBB5C19220C20EE55DE2B6B8E0C0DA6346D00362771113455A98A163207CB40A38525BE56CDBC698F73DFC9392BF2CBA6FFE3AC75B245A49E23786EE61FAC3307402FF7D616232727F115F9D96B8FE02282A299C8BD227067BB8F9504B7E0F64D36DE3C199B272CA52E990D4EF534F2BEC7FA1DA7BAFA35265120FF079108DFFDC0470BBA5F748184C58F5F8C3ABA2BBF2700A59B9A7C7BBC9AD2C304E92BE1F8252AFD62C4305B0857C2A9C6B47058835118756D631E676F077E76498532C0484D0ED571ADB3965B5CD14DB6A825B95FA79945EF114B7D62AA943E18ACFACAE01F1A2315E828D4E8EB312409A15C650366172747D774F74A544464B6819693F5F649F0081EBD249BF65B65FB95C4BC2E337620A0A218715DDF3CC87142CC50653ADE8472E50D8512C243986080405285F116F3F746C0EF3CDD353724BA09B7C4B9FEBFE6A1ABB1F1D8ECE0CC0715DBC475FF2A39AC448EF9477D661FD5C75F297C67E95C4ECC18F9643A6139B82FD1C3526167C0230F51D8B1FE10C7E00B11CB1CD371D1CD44818E61166B1E47ACE2035169C8A792CD4AD590A073A4DF21B3BE5365ADEA4D11A8F7EC5BCED5CBDC741BFBBDB8E099323235EF140C1A09CF233ABF4C32EE7FCE81757313FC4CFF9760082D0943217CCF6753205F07EF0D54105D1D5EA7FB191811F142573214EC8760082D0943217CCF6753205F07EF0D55E351148BCA3D0967594207E795AD59DB5187DDA240F7FD7E12E3DA42B8837FE4B6FD099278DCDF94348A5E9ADCF7F856873739EE57D527041F0DEF09A55A985";
        network.getUrlResource(url,params);
    }
}
