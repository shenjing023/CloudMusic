import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Rectangle{
    property string currentWindow:"discover";   //当前显示的窗口名称
    id:root;
    width: parent.width;
    height: parent.width;
    color: "#191b1f";

    //所有按钮设置未选中
    function allReset()
    {
        for(var i=0;i<itemBtnGroup.buttons.length;++i)
        {
                itemBtnGroup.buttons[i].reset();
        }
    }

    ButtonGroup{
        id:itemBtnGroup;
        //buttons:columnItem.children;
    }

    function btnGroupClicked(name)
    {
        for(var i=0;i<itemBtnGroup.buttons.length;++i)
        {
            if(name!==itemBtnGroup.buttons[i].idName)
                itemBtnGroup.buttons[i].reset();
        }
        switch(name)
        {
        case "localMusic":
            if(currentWindow!==name)
                rightWdRouter("qrc:/qml/RightWindow/LocalMusic/LocalMusic.qml",{});
            break;
        case "discover":
            rightWdRouter("qrc:/qml/RightWindow/DiscoverMusic/DiscoverMusic.qml",{});
            break;
        default:
            break;
        }
        currentWindow=name;
    }

    ListModel {
        id:model;
        ListElement {
            _id:"musicLove";
            _idName:"musicLove";
            //_width:root.width;  不能设置，会出现ListElement: cannot use script for property value错误，应该是ListElement只能用常量赋值
            //_height:30*dp;
            _symbolText:"\uf489";
            _itemText:qsTr("喜欢的音乐");
        }
        ListElement {
            _id:"new1";
            _idName:"new1";
            //_width:root.width;
            //_height:30*dp;
            _symbolText:"\uf912";
            _itemText:qsTr("新建的歌单");
        }
        ListElement {
            _id:"new2";
            _idName:"new2";
            //_width:root.width;
            //_height:30*dp;
            _symbolText:"\uf912";
            _itemText:qsTr("新建的歌单");
        }
        ListElement {
            _id:"new3";
            _idName:"new3";
            //_width:root.width;
            //_height:30*dp;
            _symbolText:"\uf912";
            _itemText:qsTr("新建的歌单");
        }

    }

    Controls_1_4.ScrollView{
        id:scrollView;
        width: parent.width;
        height: parent.height;
        horizontalScrollBarPolicy:Qt.ScrollBarAlwaysOff;
        Column{
            id:columnItem;
            anchors.left: parent.left;
            anchors.top: parent.top;
            width: root.width;
            //height: parent.width;暂时先别设置高
            spacing: 0;

            Label{
                id:leftLabel1;
                width: parent.width;
                height: 30*dp;
                anchors.left: parent.left;
                anchors.leftMargin: 10*dp;
                verticalAlignment:Label.AlignVCenter;
                text: qsTr("推荐");
                font.family: "Microsoft YaHei";
                font.pixelSize: 12*dp;
                color: "#7c7c7c";
            }

            ListItemBtn{
                id:discover;
                idName: "discover";
                width: parent.width;
                height: 30*dp;
                symbolText: "\uef51";
                itemText: qsTr("发现音乐");
                ButtonGroup.group: itemBtnGroup;

                Component.onCompleted: discover.firstClicked();
            }

            ListItemBtn{
                id:personalFM;
                idName: "personalFM";
                width: parent.width;
                height: 30*dp;
                symbolText: "\uec0b";
                itemText: qsTr("私人FM");
                ButtonGroup.group: itemBtnGroup;
            }

            ListItemBtn{
                id:mv;
                idName:"mv";
                width: parent.width;
                height: 30*dp;
                symbolText: "\uf3ac";
                itemText: qsTr("MV");
                ButtonGroup.group: itemBtnGroup;
            }

            ListItemBtn{
                id:friends;
                idName:"friends";
                width: parent.width;
                height: 30*dp;
                symbolText: "\ufb37";
                itemText: qsTr("朋友");
                ButtonGroup.group: itemBtnGroup;
            }

            Label{
                id:leftLabel2;
                width: parent.width;
                height: 30*dp;
                anchors.left: parent.left;
                anchors.leftMargin: 10*dp;
                verticalAlignment:Label.AlignVCenter;
                text: qsTr("我的音乐");
                font.family: "Microsoft YaHei";
                font.pixelSize: 12*dp;
                color: "#7c7c7c";
            }

            ListItemBtn{
                id:localMusic;
                idName:"localMusic";
                width: parent.width;
                height: 30*dp;
                symbolText: "\uf867";
                itemText: qsTr("本地音乐");
                ButtonGroup.group: itemBtnGroup;
            }

            ListItemBtn{
                id:downLoadM;
                idName:"downLoadM";
                width: parent.width;
                height: 30*dp;
                symbolText: "\uef26";
                itemText: qsTr("下载管理");
                ButtonGroup.group: itemBtnGroup;
            }

            Button{
                id:playListBtn;
                width: parent.width;
                height: 30*dp;

                background: Rectangle{
                    anchors.fill: parent;
                    color: "#191b1f";

                    Row{
                        anchors.left: parent.left;
                        width: parent.width;
                        height: parent.height;
                        spacing: 1*dp;
                        Label{
                            property bool ishovered: false;        //是否hover状态
                            id:label_list1;
                            width: parent.width-65*dp;
                            height: parent.height;
                            leftPadding: 15*dp;
                            color: "#adafb2";
                            text: qsTr("创建的歌单");
                            font.family: "Microsoft YaHei";
                            font.pixelSize: 12*dp;
                            verticalAlignment:Label.AlignVCenter;
                            wrapMode: Text.Wrap;

                            ToolTip.visible: label_list1.ishovered;
                            ToolTip.delay: 500;
                            ToolTip.text: playList.visible?qsTr("收起"):qsTr("展开");

                            MouseArea{
                                anchors.fill: parent;
                                hoverEnabled: true;
                                cursorShape: Qt.PointingHandCursor;

                                onEntered: {
                                    label_list1.ishovered=true;
                                }

                                onExited: {
                                    label_list1.ishovered=false;
                                }

                                onClicked: {
                                    playList.visible=playList.visible?false:true;
                                }
                            }
                        }

                        Label{
                            property bool ishovered: false;        //是否hover状态
                            id:newPlayListBtn;
                            color: "#adafb2";
                            width: 25*dp;
                            height: parent.height;
                            text: "\uf6c4";
                            font.family: icomoonFont.name;
                            font.pixelSize: 16*dp;
                            verticalAlignment:Label.AlignVCenter;
                            horizontalAlignment: Label.AlignHCenter;

                            ToolTip.visible: newPlayListBtn.ishovered;
                            ToolTip.delay: 500;
                            ToolTip.text: qsTr("新建歌单");

                            MouseArea{
                                anchors.fill: parent;
                                hoverEnabled: true;
                                cursorShape: Qt.PointingHandCursor;

                                onEntered: {
                                    newPlayListBtn.ishovered=true;
                                    newPlayListBtn.color="#5D5E61"
                                }

                                onExited: {
                                    newPlayListBtn.ishovered=false;
                                    newPlayListBtn.color="#adafb2"
                                }

                                onClicked: {
                                    newDialog.open();
                                }
                            }

                            Dialog{
                                id:newDialog;
                                x:(mainWindow.width-width)/2-parent.x;
                                y:(mainWindow.height-height)/2-playListBtn.y;
                                focus: true;
                                modal: true;
                                background: Rectangle{
                                    color: "#2F3134";
                                }

                                ColumnLayout{
                                    spacing: 20*dp;
                                    anchors.fill: parent;
                                    Label{
                                        elide: Label.ElideRight
                                        text: qsTr("请输入歌单名称");
                                        Layout.fillWidth: true;
                                        color: "white";
                                        font {
                                            pixelSize: 14*dp;
                                            family: "Microsoft YaHei";
                                        }
                                    }

                                    TextField{
                                        id:textField;
                                        focus: true;
                                        placeholderText: qsTr("<font color=\"black\">歌单名称</font>");

                                        font {
                                            pixelSize: 18*dp;
                                            family: "Microsoft YaHei";
                                        }

                                        Layout.fillWidth:true;
                                        selectByMouse:true;
                                    }

                                    Row{
                                        Layout.fillWidth: true;
                                        spacing: 1*dp;
                                        Button{
                                            text: qsTr("确定");
                                            font {
                                                pixelSize: 14*dp;
                                                family: "Microsoft YaHei";
                                            }

                                            MouseArea{
                                                anchors.fill: parent;
                                                hoverEnabled: true;
                                                cursorShape: Qt.PointingHandCursor;

                                                onClicked: {
                                                    newDialog.close();
                                                    if(textField.text.length!==0){
                                                        model.append({
                                                                         _id:textField.displayText,
                                                                         _idName:textField.displayText,
                                                                         _symbolText:"\uf912",
                                                                         _itemText:textField.displayText
                                                                     });
                                                        scrollView.flickableItem.contentY=playList.y;
                                                    }
                                                }
                                            }
                                        }
                                        Button{
                                            text: qsTr("取消");
                                            font {
                                                pixelSize: 14*dp;
                                                family: "Microsoft YaHei";
                                            }
                                            MouseArea{
                                                anchors.fill: parent;
                                                hoverEnabled: true;
                                                cursorShape: Qt.PointingHandCursor;

                                                onClicked: {
                                                    newDialog.close();
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }

                        Label{
                            property bool ishovered: false;        //是否hover状态
                            id:label_list2;
                            color: "#adafb2";
                            width: 25*dp;
                            height: parent.height;
                            text: playList.visible?"\ufa21":"\ufa23";
                            font.family: icomoonFont.name;
                            font.pixelSize: 18*dp;
                            verticalAlignment:Label.AlignVCenter;
                            horizontalAlignment: Label.AlignHCenter;

                            ToolTip.visible: label_list2.ishovered;
                            ToolTip.delay: 500;
                            ToolTip.text: playList.visible?qsTr("收起"):qsTr("展开");

                            MouseArea{
                                anchors.fill: parent;
                                hoverEnabled: true;
                                cursorShape: Qt.PointingHandCursor;

                                onEntered: {
                                    label_list2.ishovered=true;
                                    label_list2.color="#5D5E61";
                                }

                                onExited: {
                                    label_list2.ishovered=false;
                                    label_list2.color="#adafb2";
                                }

                                onClicked: {
                                    playList.visible=playList.visible?false:true;
                                }
                            }
                        }
                    }
                }
            }

            Column {
                id:playList;
                width: root.width;
                Repeater {
                    model: model;
                    ListItemBtn{
                        id:_id;
                        idName: _idName;
                        symbolText: _symbolText;
                        itemText: _itemText;
                        ButtonGroup.group: itemBtnGroup;
                    }
                }
            }

        }
        style:ScrollViewStyle{
            handle: Rectangle {
                implicitWidth: 5*dp;
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
                implicitWidth: 5*dp;
                implicitHeight: 0
                color: "#191b1f"
            }
            //可以使区域向上或者向右移动的区域和按钮
            decrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
            }
            //可以使区域向下或者向左移动的区域和按钮
            incrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 1
            }
        }
    }

}
