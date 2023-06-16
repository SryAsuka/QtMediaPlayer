import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml
import "../components"

ScrollView {
    clip: true

    ColumnLayout {
        Rectangle {
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x: 10
                verticalAlignment: Text.AlignBottom
                text: qsTr("推荐内容")
                font.family: window.mFONT_FAMILY
                font.pointSize: 25
            }
        }

        VideoBannerView {
            id: videoBannerView
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle {
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x:10
                verticalAlignment: Text.AlignBottom
                text: qsTr("热门歌单")
                font.family: window.mFONT_FAMILY
                font.pointSize: 25
            }
        }

        VideoGridHotView {
            id: hotView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width-250)*0.2*4+30*4+20
            Layout.bottomMargin: 20
        }
    }

    Component.onCompleted: {
        getBannerList()
    }

    function getBannerList(){

        function onReply(reply){

            getHotList()
        }

    }

    function getHotList(){

        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var playlists = JSON.parse(reply).playlists
            hotView.list =playlists
        }

        http.onReplySignal.connect(onReply)
        http.connet("top/playlist/highquality?limit=20")
    }
}
