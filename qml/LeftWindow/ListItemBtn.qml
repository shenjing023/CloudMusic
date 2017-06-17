import QtQuick 2.7
import QtQuick.Controls 2.1

Button{
    property bool isClicked: false;                 //按钮是否已点击
    property string symbolText;                     //符号名称
    property string itemText;                       //按钮名称
    property string idName;
    id:itemBtn;
    width: parent.width;
    height: 30*dp;
    //这两个属性暂时不会用
    //checkable: true;autoExclusive: true;

    signal btnClicked(string name);

    background: Rectangle{
        id:backgroundRect;
        color: "#191b1f";

        Rectangle{
            id:rect1;
            visible: false;
            width: 2*dp;
            height: parent.height;
            anchors.left: parent.left;
            color: "#b82525";
        }

        Label{
            id:btnSymbol;
            anchors{
                left: parent.left;
                leftMargin: 15*dp;
                verticalCenter: parent.verticalCenter;
            }
            color: "#adafb2";
            width: 25*dp;
            height: parent.height;
            text: symbolText;
            font.family: icomoonFont.name;
            font.pixelSize: 16*dp;
            verticalAlignment:Label.AlignVCenter;
            horizontalAlignment: Label.AlignHCenter;
        }

        Label{
            id:btnName;
            height: parent.height;
            anchors{
                left: btnSymbol.right;
                leftMargin: 10*dp;
                right: parent.right;
                rightMargin: 3*dp;
            }
            color: "#adafb2";
            verticalAlignment:Label.AlignVCenter;
            wrapMode: Text.Wrap;
            text: itemText;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12*dp;
        }

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;

            onEntered: {
                if(!isClicked)
                {
                    btnSymbol.color="#dcdde3";
                    btnName.color="#dcdde3";
                }
            }

            onExited: {
                if(!isClicked)
                {
                    btnSymbol.color="#adafb2";
                    btnName.color="#adafb2";
                }
            }

            onClicked: {
                isClicked=true;
                rect1.visible=true;
                parent.color="#26282c";
                btnClicked(idName);
            }
        }
    }

    function reset(){
        isClicked=false;
        rect1.visible=false;
        btnSymbol.color="#adafb2";
        btnName.color="#adafb2";
        backgroundRect.color="#191b1f";
    }

    //设置为已点击状态
    function firstClicked(){
        isClicked=true;
        rect1.visible=true;
        backgroundRect.color="#26282c";
    }

    Component.onCompleted: {
        itemBtn.btnClicked.connect(btnGroupClicked);
    }
}
