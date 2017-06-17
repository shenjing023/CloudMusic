import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4

Rectangle{
    property string params;
    id:root;
    color: "#16181C";
    Controls_1_4.ScrollView{
        id:searchFlickable;
        width: parent.width;
        height: parent.height;
        horizontalScrollBarPolicy:Qt.ScrollBarAlwaysOff;

        Column{
            property var searchInfo: function(count,type){
                searchLabel.text="搜索"+"<font color=\"#2e6bb0\">\""+params+"\"</font>"+",找到"+count+type;
            }

            id:rootColumn;
            width: root.width;

            Label{
                id:searchLabel;
                width: parent.width;
                height: 60*dp;
                padding: 20*dp;
                color: "#adafb2";
                verticalAlignment:Label.AlignVCenter;
                wrapMode: Text.Wrap;
                text: "搜索"+"<font color=\"#2e6bb0\">\""+params+"\"</font>";
                font.family: "Microsoft YaHei";
                font.pixelSize: 12*dp;
            }

            Row{
                property var btns: new Array();
                function tabClicked(name){
                    for(var i=0;i<btns.length;++i)
                    {
                        if(name!==btns[i].objectName)
                            btns[i].reset();
                    }
                }

                id:tab;
                anchors.left: parent.left;
                anchors.leftMargin: 20*dp;
                spacing: 5*dp;

                TabBtn{
                    id:single;
                    objectName: "single";
                    btnText: qsTr("单曲");
                    type: 1;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                    Component.onCompleted: single.firstClicked();
                }

                TabBtn{
                    id:singer;
                    objectName: "singer";
                    btnText: qsTr("歌手");
                    type: 100;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }

                TabBtn{
                    id:album;
                    objectName: "album";
                    btnText: qsTr("专辑");
                    type: 10;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }

                TabBtn{
                    id:mv;
                    objectName: "mv";
                    btnText: qsTr("MV");
                    type: 0;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }

                TabBtn{
                    id:playlist;
                    objectName: "playlist";
                    btnText: qsTr("歌单");
                    type: 1000;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }

                TabBtn{
                    id:lyric;
                    objectName: "lyric";
                    btnText: qsTr("歌词");
                    type: 0;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }

                TabBtn{
                    id:radio_station;
                    objectName: "radio_station";
                    btnText: qsTr("主播电台");
                    type: 0;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }

                TabBtn{
                    id:user;
                    objectName: "user";
                    btnText: qsTr("用户");
                    type: 1002;
                    clickedFunction: function(){
                        searchLoader.setSource("qrc:/qml/RightWindow/SearchWindow/Single.qml",{"param":params});
                    };
                }
            }

            Rectangle{
                width: parent.width;
                height: 1*dp;
                color: "#b82525"
            }

            Loader{
                id:searchLoader;
                width: parent.width;
                source: "qrc:/qml/RightWindow/SearchWindow/Single.qml";
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
