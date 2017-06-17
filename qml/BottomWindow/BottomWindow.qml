import QtQuick 2.7
import QtQuick.Controls 2.1
import QtMultimedia 5.8
import Network 1.0
import "../TitleBar"

Rectangle{
    property bool mode: false;  //网络音乐播放还是本地音乐播放（false网络，true本地）
    id:bottomWd;
    width: parent.width-2*dp;
    height: 50*dp;
    color: "#222225";

    function play(song_id){
        var url="http://music.163.com/api/song/detail/?";
        var params="id="+song_id+"&ids=%5B"+song_id+"%5D";
        songRequest.getUrlResource(url,params);
    }

    function setDuration(duration){
        var s=parseInt(duration/1000);
        var m=parseInt(s/60)>=10?parseInt(s/60):"0"+parseInt(s/60);
        var s2=parseInt(s%60)>=10?parseInt(s%60):"0"+parseInt(s%60);
        return m+":"+s2;
    }

    onModeChanged: {
        if(mode)
            mediaplayer.stop();
        else
            AudioData.stopMusic();
    }

    Network{
        id:songRequest;
        onSig_requestFinish: {
            var json=JSON.parse(bytes);
            var songs=json["songs"];
            var mp3Url=songs[0].mp3Url; //mp3直链，由于网易使用新的api，所以现在已不能获取链接
            var duration=songs[0].duration; //歌曲时间
            mediaplayer.source=mp3Url;
            mediaplayer.play();

            totalTime.text=setDuration(duration);
            playSlider.maxValue=parseInt(duration/1000);
        }
    }

    MediaPlayer{
        id:mediaplayer;
        source: "";
        //不能播放
        onError: {
            errorPopup.open();
        }
        onPlaying: {
            playBtn.state="play";
            bottomWd.mode=false;
            //timer.start();
        }
        onStopped: {
            if(!bottomWd.mode)
                playBtn.state="pause";
            //timer.stop();
        }
        onSourceChanged: {
            //timer.second=0;
            playSlider.value=0;
        }
        onPositionChanged: {
            if(!playSlider.ispressed)
                playSlider.value=position/1000;
        }
    }

    Popup{
        id:errorPopup;
        width: 150*dp;
        height:50*dp;
        x:(mainWindow.width-width)/2;
        y:(mainWindow.height-height)/2-parent.y;
        opacity: 0.5;

        background: Rectangle{
            color: "#2F3134";
            Label{
                id:lab1;
                width: 30*dp;
                height: 50*dp;
                text: "\ufa7e";
                color: "white";
                font.family: icomoonFont.name;
                font.pixelSize: 20*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignHCenter;
            }
            Label{
                id:lab2;
                anchors.left: lab1.right;
                width: 120*dp;
                height: 50*dp;
                text:qsTr("无法添加播放");
                color: "white";
                font.family: "Microsoft YaHei";
                font.pixelSize: 16*dp;
                verticalAlignment:Label.AlignVCenter;
                horizontalAlignment: Label.AlignHCenter;
            }
            Timer{
                interval: 500;
                running: errorPopup.visible;
                onTriggered: {
                    errorPopup.close();
                }
            }
        }
    }

    Row{
        width: 220*dp;
        height: parent.height;
        anchors.left: parent.left;
        anchors.leftMargin: 30;
        spacing: 25;

        BtnPlay{
            id:previousBtn;
            btnText: "\ued06";
            toolTip: qsTr("上一首");
            btnClicked: function(){
                AudioData.previousSong();
            };
        }

        Label{
            property bool ishovered: false;
            property string toolTip: qsTr("播放");
            property string btnText: "\ued03";
            id:playBtn;
            width: 35*dp;
            height: 34*dp;
            anchors.verticalCenter: parent.verticalCenter;
            verticalAlignment:Label.AlignVCenter;
            horizontalAlignment: Label.AlignHCenter;
            text: btnText;
            font.pixelSize: 34*dp;
            font.family:icomoonFont.name;
            color: "#5a5a5c";
            state: "pause";

            ToolTip.visible: ishovered;
            ToolTip.delay: 500;
            ToolTip.text: toolTip;

            states:[
                State {
                    name: "play"
                    PropertyChanges {
                        target: playBtn;
                        text:"\ued04";
                        toolTip:qsTr("暂停");
                    }
                },
                State {
                    name: "pause"
                    PropertyChanges {
                        target: playBtn;
                        text:"\ued03";
                        toolTip:qsTr("播放");
                    }
                }
            ]

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: Qt.PointingHandCursor;

                onEntered: {
                    parent.color="#fff";
                    parent.ishovered=true;
                }

                onExited: {
                    parent.color="#5a5a5c";
                    parent.ishovered=false;
                }

                onClicked: {
                    if(!bottomWd.mode)  //网络播放
                    {
                        if(mediaplayer.hasAudio)
                        {
                            if(playBtn.state==="play")
                            {
                                playBtn.state="pause";
                                mediaplayer.pause();
                            }
                            else
                            {
                                playBtn.state="play";
                                mediaplayer.play();
                            }
                        }
                    }
                    else
                    {
                        //本地
                        if(playBtn.state==="play")
                        {
                            playBtn.state="pause";
                            AudioData.pauseMusic();
                        }
                        else
                        {
                            playBtn.state="play";
                            AudioData.resumeMusic();
                        }
                    }
                }

            }
        }

        BtnPlay{
            id:nextBtn;
            btnText: "\ued07";
            toolTip: qsTr("下一首");
            btnClicked: function(){
                AudioData.nextSong();
            };
        }
    }

    Label{
        id:playingTime;
        anchors.right: playSlider.left;
        anchors.rightMargin: 3*dp;
        anchors.verticalCenter: parent.verticalCenter;
        text: "00:00";
        color: "#d2d3da";
        font.pixelSize: 14*dp;
        font.family: "Microsoft YaHei"
    }

    SliderPlay{
        id:playSlider;
        width: 400*dp;
        height: 15*dp;
        anchors.left: parent.left;
        anchors.leftMargin: 230*dp;
        anchors.verticalCenter: parent.verticalCenter;
        minValue: 0.0;
        maxValue: 10.0;
        releasedFunc: function(){
            if(!bottomWd.mode)
                mediaplayer.seek(playSlider.value*1000);
            else
                AudioData.setPosition(playSlider.value*1000);
        }
        onValueChanged: {
            playingTime.text=setDuration(parseInt(playSlider.value*1000));
            if(value===maxValue)
            {
                AudioData.nextSong();
            }
        }
    }

    Label{
        id:totalTime;
        anchors.left: playSlider.right;
        anchors.leftMargin: 3*dp;
        anchors.verticalCenter: parent.verticalCenter;
        text: "00:00";
        color: "#d2d3da";
        font.pixelSize: 14*dp;
        font.family: "Microsoft YaHei"
    }

    Label{
        property real restoreVolume;
        id:volumeLabel;
        anchors.left: totalTime.right;
        anchors.leftMargin: 20*dp;
        anchors.verticalCenter: parent.verticalCenter;
        text: "\ued15";
        color: "#79797b";
        state: "volume";
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter;
        font.family:icomoonFont.name;
        font.pixelSize: 20*dp;

        states: [
            State {
                name: "volume"
                PropertyChanges {
                    target: volumeLabel;
                    text:"\ued15";
                    color: "#79797b";
                }
            },
            State {
                name: "volume_hovered"
                PropertyChanges {
                    target: volumeLabel;
                    text:"\ued15";
                    color:"#dcdde4";
                }
            },
            State {
                name: "mutex"
                PropertyChanges {
                    target: volumeLabel;
                    text:"\ued17";
                    color: "#79797b";
                }
            },
            State {
                name: "mutex_hovered"
                PropertyChanges {
                    target: volumeLabel;
                    text:"\ued17";
                    color:"#dcdde4";
                }
            }
        ]

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;

            onEntered: {
                switch(parent.state)
                {
                case "volume":
                    parent.state="volume_hovered";
                    break;
                case "mutex":
                    parent.state="mutex_hovered";
                    break;
                }
            }

            onExited: {
                switch(parent.state)
                {
                case "volume_hovered":
                    parent.state="volume";
                    break;
                case "mutex_hovered":
                    parent.state="mutex";
                    break;
                }
            }

            onClicked: {
                if(parent.state==="volume_hovered")
                {
                    parent.state="mutex_hovered";
                    volumeLabel.restoreVolume=volumeSlider.value;
                    volumeSlider.value=0.0;
                }
                else
                {
                    parent.state="volume_hovered";
                    volumeSlider.value=volumeLabel.restoreVolume;
                }
            }
        }
    }

    SliderPlay{
        id:volumeSlider;
        width: 110*dp;
        height: 15*dp;
        anchors.left: volumeLabel.right;
        anchors.leftMargin: 3*dp;
        anchors.verticalCenter: parent.verticalCenter;
        minValue: 0.0;
        maxValue: 100.0;
        value: 50.0;

        onValueChanged: {
            if(value===0)
            {
                volumeLabel.state="mutex";
            }
            else
            {
                volumeLabel.state="volume";
            }
            if(!bottomWd.mode)
                mediaplayer.volume=value/maxValue;
            else
                AudioData.setVolumn(value);
        }
    }

    Label{
        property int mode: 0;
        property string toolTip:qsTr("顺序播放");
        property bool ishovered:false;
        id:playType;
        anchors{
            left: volumeSlider.right;
            leftMargin: 20*dp;
            verticalCenter: parent.verticalCenter;
        }
        text: "\uf904";
        color: "#7a7a7c";
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter;
        font.family:icomoonFont.name;
        font.pixelSize: 24*dp;
        state:"order";

        ToolTip.visible: ishovered
        ToolTip.delay: 500;
        ToolTip.text: toolTip;

        states: [
            State {
                name: "order"
                PropertyChanges {
                    target: playType;
                    text:"\uf904";
                    color: "#7a7a7c";
                    toolTip:qsTr("顺序播放");
                    ishovered:false;
                    mode:0;
                }
            },
            State {
                name: "order_hovered"
                PropertyChanges {
                    target: playType;
                    text:"\uf904";
                    color:"#dcdde4";
                    toolTip:qsTr("顺序播放");
                    ishovered:true;
                    mode:0;
                }
            },
            State {
                name: "list"
                PropertyChanges {
                    target: playType;
                    text:"\uf922";
                    color: "#7a7a7c";
                    toolTip:qsTr("列表循环");
                    ishovered:false;
                    mode:1;
                }
            },
            State {
                name: "list_hovered"
                PropertyChanges {
                    target: playType;
                    text:"\uf922";
                    color:"#dcdde4";
                    toolTip:qsTr("列表循环");
                    ishovered:true;
                    mode:1;
                }
            },
            State {
                name: "single"
                PropertyChanges {
                    target: playType
                    text:"\uf923";
                    color: "#7a7a7c";
                    toolTip:qsTr("单曲循环");
                    ishovered:false;
                    mode:2;
                }
            },
            State {
                name: "single_hovered"
                PropertyChanges {
                    target: playType;
                    text:"\uf923";
                    color:"#dcdde4";
                    toolTip:qsTr("单曲循环");
                    ishovered:true;
                    mode:2;
                }
            },
            State {
                name: "random"
                PropertyChanges {
                    target: playType
                    text:"\uf962";
                    color: "#7a7a7c";
                    toolTip:qsTr("随机播放");
                    ishovered:false;
                    mode:3;
                }
            },
            State {
                name: "random_hovered"
                PropertyChanges {
                    target: playType
                    text:"\uf962";
                    color:"#dcdde4";
                    toolTip:qsTr("随机播放");
                    ishovered:true;
                    mode:3;
                }
            }
        ]

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;
            acceptedButtons: Qt.LeftButton

            onEntered: {
                switch(parent.state)
                {
                case "order":
                    parent.state="order_hovered";
                    break;
                case "list":
                    parent.state="list_hovered";
                    break;
                case "single":
                    parent.state="single_hovered";
                    break;
                case "random":
                    parent.state="random_hovered";
                    break;
                }
            }

            onExited: {
                switch(parent.state)
                {
                case "order_hovered":
                    parent.state="order";
                    break;
                case "list_hovered":
                    parent.state="list";
                    break;
                case "single_hovered":
                    parent.state="single";
                    break;
                case "random_hovered":
                    parent.state="random";
                    break;
                }
            }

            onClicked: {
                switch(parent.state)
                {
                case "order_hovered":
                    parent.state="list_hovered";
                    break;
                case "list_hovered":
                    parent.state="single_hovered";
                    break;
                case "single_hovered":
                    parent.state="random_hovered";
                    break;
                case "random_hovered":
                    parent.state="order_hovered";
                    break;
                }
            }
        }

        onModeChanged: {
            AudioData.setPlayMode(mode);
        }
    }    

    Image {
        //这里本来是想显示歌词，但由于api访问原因不能获取歌词，所以改成音效，图片就懒得改了
        property bool ishovered:false;
        id: lyric;
        height: 22*dp;
        width: 22*dp;
        source: "qrc:/images/lyric(1).png";
        anchors.left: playType.right;
        anchors.leftMargin: 15*dp;
        anchors.verticalCenter: parent.verticalCenter;

        ToolTip.visible: ishovered
        ToolTip.delay: 500;
        ToolTip.text: soundEffect.visible?qsTr("关闭音效设置"):qsTr("打开音效设置");

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;

            onEntered: {
                parent.source="qrc:/images/lyric(2).png";
                parent.ishovered=true;
            }

            onExited: {
                parent.source="qrc:/images/lyric(1).png";
                parent.ishovered=false;
            }

            onClicked: {
                if(bottomWd.mode)
                {
                    if(!AudioData.playStatus())
                    {
                        if(!soundEffect.visible)
                            soundEffect.visible=true;
                        else
                            soundEffect.visible=false;
                    }
                }
            }
        }
    }


    Rectangle{
        property bool ishovered:false;
        color: "#2d2d30";
        width: 70*dp;
        height: 20*dp;
        anchors.left: lyric.right;
        anchors.leftMargin: 15*dp;
        anchors.verticalCenter: parent.verticalCenter;

        ToolTip.visible: ishovered
        ToolTip.delay: 500;
        ToolTip.text: qsTr("打开播放列表");

        Image {
            id: listLyric
            width: 20*dp;
            height: 20*dp;
            anchors.left: parent.left;
            anchors.top: parent.top;
            source: "qrc:/images/list_lyric(1).png";
        }

        Rectangle{
            width: 50*dp;
            height: 20*dp;
            anchors.left: listLyric.right;
            anchors.top: parent.top;
            color: "#2d2d30";

            Label{
               anchors.fill: parent;
                text: qsTr("<font color=\"white\">0</font>");
                font.family: qsTr("Microsoft YaHei");
                font.pixelSize: 18*dp;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
            }
        }

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            cursorShape: Qt.PointingHandCursor;

            onEntered: {
                listLyric.source="qrc:/images/list_lyric(2).png";
                parent.ishovered=true;
            }

            onExited: {
                listLyric.source="qrc:/images/list_lyric(1).png";
                parent.ishovered=false;
            }

            onClicked: {

            }
        }
    }

    Connections{
        target: AudioData;
        onSig_positionChanged:{
            if(!playSlider.ispressed)
                playSlider.value=milliseconds/1000;
        }
        onSig_musicInfo:{
            totalTime.text=setDuration(duration);
            playSlider.maxValue=parseInt(duration/1000);
            playBtn.state="play";
            bottomWd.mode=true;
            //setabc();
            playWindow.visible=true;
            playWindow.updateInfo(_title,album,artists);
        }
    }

    Rectangle{
        property string imageUrl:"";   //图片url
        property string title:"";          //音乐标题
        property string artists:"";        //歌手
        property string album:"";   //专辑
        id:playWindow;
        anchors{
            left: parent.left;
            bottom: parent.top;
        }
       color: "#191b1f";
       visible: false;

       function updateInfo(_title,_album,_artists)
       {
           title=_title.length===0?qsTr("未知音乐"):_title;
           album=_album===""?qsTr("未知专辑"):_album;
           artists=_artists===""?qsTr("未知歌手"):_artists;
       }

       MouseArea{
           anchors.fill: parent;
           hoverEnabled: true;
       }

        Behavior on state{
            PropertyAnimation {duration: 100}
        }

        function changeSource(){
            loader.setSource("qrc:/qml/SpectrumWindow/MiniWindow.qml"/*,{"imageUrl":imageUrl,"title":title,"artists":artists}*/);
        }

        Loader{
            id:loader;
        }

        state: "mini";
        states: [
            State {
                name: "mini"
                PropertyChanges {
                    target: playWindow;
                    width:200*dp;
                    height:65*dp;
                }
            },
            State {
                name: "max"
                PropertyChanges {
                    target: playWindow;
                    width:998*dp;
                    height:575*dp;
                }
            }
        ]

        onStateChanged: {
            if(playWindow.state=="mini")
                loader.setSource("qrc:/qml/SpectrumWindow/MiniWindow.qml"/*,{"imageUrl":imageUrl,"title":title,"artists":artists}*/);
            else
                loader.setSource("qrc:/qml/SpectrumWindow/MaxWindow.qml");
        }
    }

    Rectangle{
        id:soundEffect;
        anchors{
            right: parent.right;
            bottom: parent.top;
        }
        width: 300*dp;
        height: 215*dp;
        color: "#222225";
        visible: false;

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
        }

        TitleBarBtn{
            anchors{
                top:parent.top;
                right: parent.right;
                rightMargin: 5*dp;
            }
            btnWidth: 30*dp;
            btnHeight: 30*dp;
            btnText: "\uf4e6";
            fontSize: 18*dp;
            fontColor: "#828487";
            hovered_fontColor: "#dcdde4";
            toolTip: qsTr("关闭");
            backgroundColor: "#222225";

            btnClicked: function(){
                soundEffect.visible=false;
            }
        }

        Grid{
            id:grid1;
            anchors
            {
                left:parent.left;
                leftMargin:20*dp;
                top:parent.top;
                topMargin:20*dp;
            }
            columns: 2;
            rows:2;
            spacing: 5*dp;
            horizontalItemAlignment: Grid.AlignHCenter;
            verticalItemAlignment: Grid.AlignVCenter;

            Repeater{
                id:repeater1;
                model: ["回声","EQ均衡器","消除人声","混合立体声道"];
                delegate: CustomSwitch{
                    switchText: modelData;
                }
            }

        }

        Grid{
            id:grid2;
            anchors
            {
                left:parent.left;
                leftMargin:20*dp;
                top:grid1.bottom;
                topMargin:10*dp;
            }
            columns: 2;
            rows:3;
            spacing: 10*dp;
            horizontalItemAlignment: Grid.AlignHCenter;
            verticalItemAlignment: Grid.AlignVCenter;

            Label{
                text:"Rate";
                font{
                    family: "Microsoft YaHei";
                    pixelSize: 12*dp;
                }
                color: "white";
            }
            CustomSlider{
                id:rate;
                width: 200*dp;
                height: 15*dp;
                minValue: 0.0;
                maxValue: 200.0;
                value: 100.0;
                onValueChanged: {
                    AudioData.setRate(rate.value);
                }

//                releasedFunc: function(){
//                    AudioData.setRate(rate.value);
//                }
            }
            Label{
                text:"音高";
                font{
                    family: "Microsoft YaHei";
                    pixelSize: 12*dp;
                }
                color: "white";
            }
            CustomSlider{
                id:pitch;
                width: 200*dp;
                height: 15*dp;
                minValue: 0.0;
                maxValue: 200.0;
                value: 100.0;
                onValueChanged: {
                    AudioData.setPitch(pitch.value);
                }


            }
            Label{
                text:"播放速度";
                font{
                    family: "Microsoft YaHei";
                    pixelSize: 12*dp;
                }
                color: "white";
            }
            CustomSlider{
                id:tempo;
                width: 200*dp;
                height: 15*dp;
                minValue: 0.0;
                maxValue: 200.0;
                value: 100.0;
                onValueChanged: {
                    AudioData.setTempo(tempo.value);
                }

            }
        }

        Button{
            width: 70*dp;
            height: 30*dp;
            anchors{
                right: parent.right;
                rightMargin: 20*dp;
                top:grid2.bottom;
                topMargin: 10*dp;
            }

            text: qsTr("恢复默认");
            font{
                family: "Microsoft YaHei";
                pixelSize: 12*dp;
            }
            background: Rectangle{
                anchors.fill: parent;
                radius: 1*dp;
                color: "#adafb2";
            }

            onClicked: {
                rate.value=100;
                pitch.value=100;
                tempo.value=100;
                repeater1.itemAt(0).checked=false;
                repeater1.itemAt(1).checked=false;
                repeater1.itemAt(2).checked=false;
                repeater1.itemAt(3).checked=false;
            }
        }
    }

}
