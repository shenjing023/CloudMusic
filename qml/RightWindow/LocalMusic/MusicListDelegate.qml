import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property bool isClicked: false;
    property int _index;    //序号
    property string title;  //音乐标题
    property string artists;//歌手
    property string album;//专辑
    property string duration;   //时长
    property string  size;     //大小
    property string path;   //音乐文件路径
    property color bkColor: {
        if(_index%2===0)
            return "#1a1c20";
        else
            return "transparent";
    }

    id:root;
    width: parent.width;
    height: 30*dp;
    color: bkColor;

    function mouseEntered(){
        if(!isClicked)
            root.color="#232529"
    }
    function mouseExited(){
        if(!isClicked)
            root.color=bkColor;
    }
    function mouseClicked(){
        root.color="#2c2e32";
        isClicked=true;
        root.parent.itemClicked(_index);
    }

    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;

        onEntered: {
            mouseEntered();
        }
        onExited:{
            mouseExited();
        }
        onClicked: {
            mouseClicked();
        }
        onDoubleClicked: {
            AudioData.playMusic(path);
            setMusicInfo();
        }
    }

    Row{
        width: parent.width;
        height: parent.height;
        spacing: 5*dp;

        Label{
            width: 60*dp;
            height: parent.height;
            text: _index<10?"0"+_index:_index;
            padding: 5*dp;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignRight;
            color: "#828385";
        }

        //音乐标题
        Label{
            property bool ishovered: false;
            width: 245*dp;
            height: parent.height;
            text: title.length===0?qsTr("未知音乐"):title;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            color: "#e2e2e2";
            elide:Text.ElideRight;

            ToolTip.visible: ishovered;
            ToolTip.delay: 500;
            ToolTip.text: title;

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                propagateComposedEvents: true

                onEntered: {
                    mouseEntered();
                    parent.ishovered=true;
                }
                onExited: {
                    mouseExited();
                    parent.ishovered=false;
                }
                onClicked: {
                    mouseClicked();
                }
                onDoubleClicked: {
                    mouse.accepted = false;
                }
            }
        }

        //歌手
        Label{
            property bool ishovered: false;
            width: 125*dp;
            height: parent.height;
            text: artists===""?qsTr("未知歌手"):artists;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            color: "#e2e2e2";
            elide:Text.ElideRight;

            ToolTip.visible: ishovered;
            ToolTip.delay: 500;
            ToolTip.text: artists;

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                propagateComposedEvents: true

                onEntered: {
                    mouseEntered();
                    parent.ishovered=true;
                }
                onExited: {
                    mouseExited();
                    parent.ishovered=false;
                }
                onClicked: {
                    mouseClicked();
                }
                onDoubleClicked: {
                    mouse.accepted = false;
                }
            }
        }

        //专辑
        Label{
            property bool ishovered: false;
            width: 175*dp;
            height: parent.height;
            text:album===""?qsTr("未知专辑"):album;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            color: "#e2e2e2";
            elide:Text.ElideRight;

            ToolTip.visible: ishovered;
            ToolTip.delay: 500;
            ToolTip.text: album;

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                propagateComposedEvents: true

                onEntered: {
                    mouseEntered();
                    parent.ishovered=true;
                }
                onExited: {
                    mouseExited();
                    parent.ishovered=false;
                }
                onClicked: {
                    mouseClicked();
                }
                onDoubleClicked: {
                    mouse.accepted = false;
                }
            }
        }

        //时长
        Label{
            width: 65*dp;
            height: parent.height;
            text: duration;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            color: "#e2e2e2";
        }
        //大小
        Label{
            width: 65*dp;
            height: parent.height;
            text: size;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            color: "#e2e2e2";
        }
    }

    function reset(){
        root.color=bkColor;
        isClicked=false;
    }
    Component.onCompleted: {
        parent.items.push(root);
    }
}
