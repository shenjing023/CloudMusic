import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4

Rectangle{
    id:root;
    //高和宽最后再设置
//    width: 798*dp;
//    height: 1000*dp;
    color: "#16181C";
    Controls_1_4.ScrollView{
        id:discoverFlickable;
        width: parent.width;
        height: parent.height;
        horizontalScrollBarPolicy:Qt.ScrollBarAlwaysOff;

        Column{
            id:column;
            width: root.width-40*dp;
            anchors.left: parent.left;
            anchors.leftMargin: 20*dp;
            spacing: -2*dp;

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
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 20*dp;
                z:2;

                TabBtn{
                    id:recommand;
                    objectName: "recommand";
                    width: 65*dp;
                    height: 40*dp;
                    btnText: qsTr("个性推荐");
                    color_hovered: "#DCDDE4";
                    btnClickFunc: function(){
                        tabLoader.source="qrc:/qml/RightWindow/DiscoverMusic/Recommand/Recommand.qml";
                    }
                    Component.onCompleted: recommand.firstClicked();
                }

                TabBtn{
                    id:songList;
                    objectName: "songList";
                    width: 65*dp;
                    height: 40*dp;
                    btnText: qsTr("歌单");
                    color_hovered: "#DCDDE4";
                    btnClickFunc: function(){
                        tabLoader.source="qrc:/qml/RightWindow/Developing.qml";
                    }
                }

                TabBtn{
                    id:radioAnchor;
                    objectName: "radioAnchor";
                    width: 65*dp;
                    height: 40*dp;
                    btnText: qsTr("主播电台");
                    color_hovered: "#DCDDE4";
                    btnClickFunc: function(){
                        tabLoader.source="qrc:/qml/RightWindow/Developing.qml";
                    }
                }

                TabBtn{
                    id:ranking;
                    objectName: "ranking";
                    width: 65*dp;
                    height: 40*dp;
                    btnText: qsTr("排行榜");
                    color_hovered: "#DCDDE4";
                    btnClickFunc: function(){
                        tabLoader.source="qrc:/qml/RightWindow/Developing.qml";
                    }
                }

                TabBtn{
                    id:singer;
                    objectName: "singer";
                    width: 65*dp;
                    height: 40*dp;
                    btnText: qsTr("歌手");
                    color_hovered: "#DCDDE4";
                    btnClickFunc: function(){
                        tabLoader.source="qrc:/qml/RightWindow/Developing.qml";
                    }
                }

                TabBtn{
                    id:newMusic;
                    objectName: "newMusic";
                    width: 65*dp;
                    height: 40*dp;
                    btnText: qsTr("最新音乐");
                    color_hovered: "#DCDDE4";
                    btnClickFunc: function(){
                        tabLoader.source="qrc:/qml/RightWindow/Developing.qml";
                    }
                }

            }

            Rectangle{
                width: parent.width;
                height: 2*dp;
                color: "#202226";
                z:1;
            }
            Rectangle{
                width: root.width-40*dp;
                height: 5*dp;
                color: "transparent"
            }

            Loader{
                id:tabLoader;
                width: root.width-40*dp;
                source: "qrc:/qml/RightWindow/DiscoverMusic/Recommand/Recommand.qml"
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
