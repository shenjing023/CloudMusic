import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../../Utils"

Rectangle{
    property  int _index;                   //序号
    property string name1;               //歌曲主名
    property string name2;              //歌曲副名
    property string artists;                   //歌手
    property bool isSQ;                 //歌曲是不是SQ
    property bool isMV;                 //是否有MV
    property string imageSource;    //图片url
    property string mp3Url;         //mp3Url

    property bool isClicked: false;
    property color bkColor: {
        switch(_index)
        {
        case 3:
        case 4:
        case 7:
        case 8:
            return "#1a1c20";
        default:
            return "transparent";
        }
    }

    id:root;
    width: 378*dp;
    height: 60*dp;
    color: bkColor;

    //这个一定放在前面，如果放在末尾，子元素中的MouseArea会被覆盖
//    MouseArea{
//        anchors.fill: parent;
//        hoverEnabled: true;
//        cursorShape:Qt.ArrowCursor;
//    }
//这个一定放在前面，如果放在末尾，子元素中的MouseArea会被覆盖
    CustomMouseArea{
        _cursorShape:Qt.ArrowCursor;
        _onEnteredFunction:mouseEntered;
        _onExitedFunction:mouseExited;
        _onClickedFunction:mouseClicked;
        isToolTip: false;
    }


    Row{
        width: parent.width;
        height: 40*dp;
        anchors.verticalCenter: parent.verticalCenter;
        spacing: 10*dp;

        //序号
        Label{
            id:indexLab;
            width: 30*dp;
            height: parent.height;
            text: (_index<10)?"0"+_index:_index.toString();
            color: "#4e4e52";
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter;
        }

        //图片
        Image {
            id: image;
            width: 40*dp;
            height: parent.height;
            source: imageSource;

            CustomMouseArea{
                _cursorShape:Qt.PointingHandCursor;
                _onEnteredFunction:mouseEntered;
                _onExitedFunction:mouseExited;
                _onClickedFunction:mouseClicked;
                isToolTip: false;
            }

            Rectangle{
                anchors.centerIn: parent;
                width: 25*dp;
                height: 25*dp;
                radius: 25*dp;
                color: "black";
                opacity: 0.5;
                border{
                    color: "white";
                    width: 1*dp;
                }

                Label{
                    width: 15*dp;
                    height: 15*dp;
                    anchors.centerIn: parent;
                    text: "\uf8fe";
                    color: "#f5f4f2";
                    font.pixelSize: 20*dp;
                    font.family:icomoonFont.name;
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter;
                }

                CustomMouseArea{
                    _cursorShape:Qt.PointingHandCursor;
                    _onEnteredFunction:mouseEntered;
                    _onExitedFunction:mouseExited;
                    _onClickedFunction:mouseClicked;
                    isToolTip: false;
                    //下面的几个信号槽函数感觉不是重写，好像会先执行相当于基类
                    //CustomMouseArea的函数，然后再执行相当于子类的
                    //CustomMouseArea的函数，有了这个特性，相当于在
                    //原有的基础上再添加了改变，可能有意想不到的效果
                    onEntered: {
                        parent.opacity=0.8;
                    }

                    onExited: {
                        parent.opacity=0.5;
                    }

                    onClicked: {

                    }
                }
            }

        }

        Column{
            width: parent.width-80*dp;
            height: parent.height;
            spacing: 0;

            Row{
                id:row1;
                width: parent.width;
                height: parent.height/2;
                spacing: 5*dp;
                //主名
                Label{
                    id:lab1;
                    //width: row1.width/2;
                    height: parent.height;
                    text: name1;
                    elide:Text.ElideRight
                    color: "white";
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 16*dp;
                    verticalAlignment:Label.AlignVCenter;
                    horizontalAlignment: Label.AlignLeft;

                    CustomMouseArea{
                        _cursorShape:Qt.ArrowCursor;
                        _onEnteredFunction:mouseEntered;
                        _onExitedFunction:mouseExited;
                        _onClickedFunction:mouseClicked;
                        toolTip: name2.length>0? name1+" ("+name2+")":name1;
                    }

                }
                //副名
                Label{
                    id:lab2;
                    //width: parent.width/2;
                    height: parent.height;
                    padding: 3*dp;
                    text: "("+name2+")";
                    elide:Text.ElideRight
                    color: "#5f5f63";
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 16*dp;
                    verticalAlignment:Label.AlignVCenter;
                    horizontalAlignment: Label.AlignLeft;
                    visible: name2.length>0?true:false;

                    CustomMouseArea{
                        _cursorShape:Qt.ArrowCursor;
                        _onEnteredFunction:mouseEntered;
                        _onExitedFunction:mouseExited;
                        _onClickedFunction:mouseClicked;
                        toolTip: name1+" ("+name2+")";
                    }
                }

                Component.onCompleted: {//console.log("l:",lab1.visible)
                    //这里不能用lab2.visible来判断，无论lab2显示还是不显示，返回都是false，
                    //lab1都是返回false
                    if(name2.length>0)
                    {
                        //调整宽度，这里还需要进一步调整
                        if(lab1.width>=row1.width)
                        {
                            //不知为什么row1.width不够宽
                            lab1.width=row1.width-10*dp;
                            lab2.visible=false;/*console.log("1: ",_index,"w:",row1.width);*/
                        }
                        else if(lab1.width+lab2.width>row1.width)
                        {
                            lab2.width=row1.width-lab1.width-15*dp;
                        }
                        else
                        {
                            lab2.width=row1.width-lab1.width-15*dp;
                        }
                    }
                    else
                    {
                        //如果不减10*dp，有的时候会超出边界，不知为什么
                        lab1.width=row1.width-10*dp;
                    }
                }

            }

            //这个可以不用row，因为要改变每一个元素的宽度，感觉还不如anchors方便
            Row{
                id:row2;
                width: parent.width;
                height: parent.height/2;
                spacing: 7*dp;
                //SQ
                Label{
                    id:labSQ;
                    width: 18*dp;
                    height: parent.height-2*dp;
                    anchors.bottom: parent.bottom;
                    //padding: 5*dp;
                    text: "SQ";
                    color: "#a94926";
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 10*dp;
                    verticalAlignment:Label.AlignVCenter;
                    horizontalAlignment: Label.AlignLeft;
                    visible: isSQ;
                }
                //MV
                Label{
                    id:labMV;
                    width: 18*dp;
                    height: parent.height-3*dp;
                    anchors.bottom: parent.bottom;
                    //padding: 5*dp;
                    text: "\uf3ac";
                    color: "#b82525";
                    font.family:icomoonFont.name;
                    font.pixelSize: 16*dp;
                    verticalAlignment:Label.AlignVCenter;
                    horizontalAlignment: Label.AlignLeft;
                    visible: isMV;
                }
                //歌手
                Label{
                    id:singer;
                    height: parent.height;
                    width: {
                        if(labSQ.visible&&labMV.visible)
                            return row2.width-36*dp-25*dp;
                        else if(labSQ.visible||labMV.visible)
                            return row2.width-18*dp-21*dp;
                        else
                            return row2.width;
                    }

                    text: artists;
                    elide: Label.ElideRight;
                    color: "#5f5f63";
                    font.family: "Microsoft YaHei";
                    font.pixelSize: 16*dp;
                    verticalAlignment:Label.AlignVCenter;
                    horizontalAlignment: Label.AlignLeft;

                    CustomMouseArea{
                        _cursorShape:Qt.PointingHandCursor;
                        _onEnteredFunction:mouseEntered;
                        _onExitedFunction:mouseExited;
                        _onClickedFunction:mouseClicked;
                        toolTip: artists;
                    }
                }
            }


        }

    }



    function reset(){
        root.color=bkColor;
        isClicked=false;
        singer.color="#5f5f63";
        lab2.color="#5f5f63";
    }

    property var mouseEntered:function() {
        if(!isClicked)
        {
        root.color="#25272b";
        singer.color="#dcdde4";
        }
    }

    property var mouseExited:function(){
        if(!isClicked)
        {
            root.color=bkColor;
            singer.color="#5f5f63";
        }
    }

    property var mouseClicked:function(){
        lab2.color="#dedde4";
        indexLab.color="#dedde4";
        isClicked=true;
        root.parent.itemClicked(_index);
    }

    Component.onCompleted: {
        parent.items.push(root);
    }
}
