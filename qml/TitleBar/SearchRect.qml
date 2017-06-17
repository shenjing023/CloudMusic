import QtQuick 2.7
import QtQuick.Controls 2.1
import Network 1.0

BorderImage {
    id: root;
    source: "qrc:/images/searchBorderImg.png";
    width: 230*dp;
    height: searchListView.height+lab.height+20*dp;
    border{
        top:20*dp;
        bottom: 10*dp;
        left: 10*dp;
        right: 10*dp;
    }
    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Stretch

    Network{
        id:network;
        onSig_requestFinish: {
            var json=JSON.parse(bytes);
            var hots=json.result.hots;
            searchModel.clear();
            for (var i in hots)
            {
                searchModel.append({"_text":hots[i].first});
            }
        }
    }

    Label{
        id:lab;
        anchors.top: parent.top;
        anchors.topMargin: 10*dp;
        anchors.leftMargin: 2*dp;
        width: parent.width-4*dp;
        padding: 5*dp;
        text: qsTr("热门搜索");
        font{
            family: "Microsoft YaHei";
            pixelSize: 12*dp;
        }
        color: "#5f5f63";
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignLeft;
    }

    Rectangle{
        id:rect;
        width: lab.width;
        height: 1*dp;
        anchors.left: parent.left;
        anchors.leftMargin: 2*dp;
        anchors.top: lab.bottom;
        color: "#36383c";
    }

    ListModel{
        id:searchModel;
    }

    ListView{
        id:searchListView;
        anchors.top: rect.bottom;
        anchors.left: parent.left;
        anchors.leftMargin: 2*dp;
        width: parent.width-4*dp;
        height: searchModel.count*25*dp;
        model: searchModel;
        delegate: Label{
            width: parent.width;
            height: 25*dp;
            padding: 5*dp;
            text: _text;
            font{
                family: "Microsoft YaHei";
                pixelSize: 12*dp;
            }
            color: "#a5a7a8";
            elide:Text.ElideRight
            verticalAlignment:Label.AlignVCenter;
            horizontalAlignment: Label.AlignLeft;
            background: Rectangle{
                id:bkRect;
                implicitHeight: parent.height;
                implicitWidth: parent.width;
                color: "transparent";
            }

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: Qt.PointingHandCursor;

                onEntered: {
                    bkRect.color="#333539";
                }

                onExited: {
                    bkRect.color="transparent";
                }

                onClicked: {

                }
            }
        }
    }

    Component.onCompleted: {
        var url="http://music.163.com/eapi/search/hot";
        var params="886AF8D09CBF98AE6DEE4A18C0124D90E49B69771D767F86360407771BFDD3C514484B6334D76221C50A65091D55F4BECCB7DA176A2DF9E7AA821CE886357AA078BE10136C8787449E401E0F0628E629BFE124230A542288123C2D43CBDDCA333B9FC3F2F3593CF55A71704D7EDC29F2FA9DADAAA96FA3D5B56F1E3266FC695CDF85533FEA718938C037BD1D8C63EF344C849F2AC342EB5F9239AD643E026040E631BAB9BC85C97D80160B5920BBF59E54C1655B34B8E3C29570B0D36D87E246AD9A9F926C5E1B3979139277DBCDF27EEFA8C8B01F0D98BCF926649FDFBB0DAA8E9FBEED38AB0948E826440AF921CE3D85298DCFD24E3BBE63885BC3C13D732A5A6379C467C2864A24B0DA507090C79AF74DA5640B928C727CCE2044FB3CA3B797D39E54BB50AA611A3B1F18E08AB3F6C31A7042B0781D2A7F47A66BFA538CC03C575E26D00803A4DF00E5EB63D60A6F34157EAFF33FCE44F11204452D12162039DBE84C43F47E809AA760CC5FD03E9E6AA3B102FBE7296AB0DB9EA5C46AD12B";
        network.getUrlResource(url,params);
    }
}
