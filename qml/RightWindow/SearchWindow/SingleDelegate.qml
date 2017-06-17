import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property bool isClicked: false;
    property string param;  //搜索关键词
    property int _index;    //序号
    property string title;  //音乐标题
    property string artists;//歌手
    property string album;//专辑
    property int duration;   //时长
    property string song_id;    //歌曲id
    property color bkColor: {
        if(_index%2===0)
            return "#1a1c20";
        else
            return "transparent";
    }
    property string strDuration: {
        var s=parseInt(duration/1000);
        var m=parseInt(s/60)>=10?parseInt(s/60):"0"+parseInt(s/60);
        var s2=parseInt(s%60)>=10?parseInt(s%60):"0"+parseInt(s%60);
        return m+":"+s2;
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
            playSong(song_id);
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

        Label{
            width: 60*dp;
            height: parent.height;

            Label{
                property bool ishovered: false;
                property bool isClicked: false;
                width: 25*dp;
                height: parent.height;
                color: "#333538";
                text: "\ufab4";
                font.family: icomoonFont.name;
                font.pixelSize: 16*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignHCenter;

                ToolTip.visible: ishovered;
                ToolTip.delay: 500;
                ToolTip.text: qsTr("喜欢");

                MouseArea{
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;

                    onEntered: {
                        mouseEntered();
                        parent.ishovered=true;
                        if(parent.isClicked)
                            parent.color="#cd2929";
                        else
                            parent.color="#898a8c";
                    }
                    onExited: {
                        mouseExited();
                        if(parent.isClicked)
                            parent.color="#b82525";
                        else
                            parent.color="#333538";
                        parent.ishovered=false;
                    }
                    onClicked: {
                        mouseClicked();
                        parent.text=parent.text==="\ufab4"?"\ufab5":"\ufab4";
                        parent.color=parent.text==="\ufab4"?"#898a8c":"#cd2929";
                        if(parent.text==="\ufab4")
                            parent.isClicked=false;
                        else
                            parent.isClicked=true;
                    }
                }
            }

            Label{
                property bool ishovered: false;
                width: 25*dp;
                height: parent.height;
                anchors.right: parent.right;
                anchors.rightMargin: 5*dp;
                color: "#333538";
                text: "\uef26";
                font.family: icomoonFont.name;
                font.pixelSize: 16*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignHCenter;

                MouseArea{
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;

                    onEntered: {
                        mouseEntered();
                        parent.ishovered=true;
                        parent.color="#959698";
                    }
                    onExited: {
                        mouseExited();
                        parent.color="#333538";
                        parent.ishovered=false;
                    }
                    onClicked: {

                    }
                }
            }
        }
        //音乐标题
        Label{
            property bool ishovered: false;
            width: 245*dp;
            height: parent.height;
            text: highLight(title);
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
            text: highLight(artists);
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
            //text: "<font color=\"#2e6bb0\">"+param+"</font>";//，如果这样使用，会把
            //根组件的mouseEnter和mouseExit响应屏蔽，不知为何
            text:highLight(album);
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
            width: 25*dp;
            height: parent.height;
            text: strDuration;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            color: "#e2e2e2";
        }

//        Rectangle{
//            width: 80*dp;
//            height: 5*dp;
//            anchors.verticalCenter: parent.verticalCenter;
//            radius: 5*dp;
//            color: "#24262a";

//            Rectangle{
//                width: 50*dp;
//                height: parent.height;
//                radius: 5*dp;
//                color: "#2e3033";
//            }
//        }
    }

    function reset(){
        root.color=bkColor;
        isClicked=false;
    }

    function highLight(str){
        if(str.indexOf(param)<0)
            return str;
        else
        {
            var array=str.split(param);
            var tmp="";
            for(var i=0;i<array.length-1;++i)
            {
                tmp+=array[i];
                tmp+="<font color=\"#2e6bb0\">"+param+"</font>";
            }
            tmp+=array[array.length-1];
            return tmp;
        }
    }

    Component.onCompleted: {
        parent.items.push(root);
    }
}
