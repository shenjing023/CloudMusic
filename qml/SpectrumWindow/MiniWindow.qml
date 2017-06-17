import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle{
    property string imageUrl:miniWindow.parent.parent.imageUrl;   //图片url
    property string title:miniWindow.parent.parent.title;          //音乐标题
    property string artists:miniWindow.parent.parent.artists;        //歌手
    id:miniWindow;
    width: 200*dp;
    height: 65*dp;
//    anchors{
//        left: parent.left;
//        bottom: parent.top;
//    }
   color: "#191b1f";

//   function updateInfo(_title,_album,_artists){
//       miniWindow.title=_title;
//       miniWindow.artists=_artists;
//   }

   Rectangle{
       width: parent.width;
       height: 1*dp;
       color: "#23262c";
   }

   Image {
       id: image;
       source: miniWindow.imageUrl===""?"qrc:/images/ABC23.png":miniWindow.imageUrl;
       width: 70*dp;
       height: parent.height;

       MouseArea{
           anchors.fill: parent;
           hoverEnabled: true;
           cursorShape: Qt.PointingHandCursor;

           onClicked: {
               miniWindow.parent.parent.state="max";
           }
       }
   }

   Column{
       width: 130*dp;
       height: parent.height-1*dp;
       anchors.left: image.right;
       anchors.top: parent.top;

       Label{
           width: 120*dp;
           height: parent.height/2;
           padding: 5*dp;
           verticalAlignment: Label.AlignVCenter;
           text:miniWindow.title;
           color: "white";
           font{
               family:"Microsoft YaHei";
               pixelSize: 12*dp;
           }
           elide:Text.ElideRight;
       }
       Label{
           width: 120*dp;
           height: parent.height/2;
           padding: 5*dp;
           verticalAlignment: Label.AlignVCenter;
           text:miniWindow.artists;
           color: "white";
           font{
               family:"Microsoft YaHei";
               pixelSize: 12*dp;
           }
           elide:Text.ElideRight;
       }
   }

}
