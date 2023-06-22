/**
 * 作者：范榆康
 * 日期：2023.6.13
 * 播放页面
 * 2023.6.15上午：实现双击全屏
 */
import QtQuick
import QtQuick.Controls
import QtMultimedia
import "../components"

Rectangle {

    property alias video: video
    property alias player: player
    property alias pSubText: subtitleText

    // 是否全屏
    property bool bFullSreen: false
    // 视频是否播放
    readonly property bool bRunning: player.playbackState == MediaPlayer.PlayingState
    // 是否开启字幕
    property bool bCaptionOn: true
    // 是否被收藏
    property bool bCollect: false

    property point point: Qt.point(x,y)

    property PlayFileList playFileList: playFileListComponents

    property BullectSettingDrawer bullectSettingDrawer: bullectSettingConmponents


    id: videoPlayer
    color: "black"

    // 视频播放器
    VideoOutput {
        id: video
        anchors.fill: parent
    }

    MediaPlayer {
        id: player
        audioOutput: AudioOutput {}
        videoOutput: video

        onPositionChanged: {
            subProvider.getSrtSubText(player.position)
        }
    }

    //Fan: 加载VideoControl视频控制组件
    //Li:  进度条控制部分
    VideoControl {
        id: videoControl
        anchors.bottom: parent.bottom

        player: player
        hideTimer: hideProgressBarTimer

        // 出现设置
        opacity: 0  // 默认透明度为0，即完全透明
        Behavior on opacity {  // 添加动画行为
            OpacityAnimator { duration: 300 }
        }

        Behavior on height {  // 添加动画行为
            NumberAnimation { duration: 300 }
        }
    }

    // 加载VideoTitleBar视频标题组建
    VideoTitleBar {
        id: videoTitleBar
        anchors.top: parent.top
        hideTimer: hideProgressBarTimer

        // 出现设置
        opacity: 0  // 默认透明度为0，即完全透明
        Behavior on opacity {  // 添加动画行为
            OpacityAnimator { duration: 300 }
        }

        Behavior on height {  // 添加动画行为
            NumberAnimation{ duration: 300 }
        }
    }

    //Fan: 加载PlayFileList播放列表组件
    //Li:  从AbstractListModel中获取数据
    PlayFileList{
        id: playFileListComponents

        controlTime: hideProgressBarTimer
    }

    // 加载弹幕设置BullectSettingDrawer组件
    BullectSettingDrawer {
        id: bullectSettingConmponents
    }

    // 屏幕中间的播放按钮，点击一下视频暂停图标显示，再点击视频播放图标隐藏
    Rectangle {
        id:starButton
        anchors {
            fill: parent
            topMargin: 80
            bottomMargin: 120
        }

        anchors.centerIn: parent
        color: "transparent"

        MouseArea {
            id:videoMouseArea
            anchors.fill: parent
            /*singleClick() */
            // 避免 双击/单击 事件同时触发
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            property int clickNum: 0
            Timer {
                id:timer
                interval: 200
                onTriggered: {
                    videoMouseArea.clickNum = 0
                    timer.stop()
                    singleClick()
                }//计时超时，触发单击事件
            }
            onClicked: {
                clickNum++
                if (clickNum == 1) {
                    timer.start()
                }
                if (clickNum == 2) {
                    clickNum = 0
                    timer.stop()
                    dblClick()
                }

            }
        }

    }

    // 鼠标监听区域,实现鼠标移动视频控制组件、视频标题组件出现
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true  // 启用鼠标悬停
        propagateComposedEvents: true

        // 鼠标移动时显示进度条和播放/暂停按钮，并启动计时器
        onPositionChanged: {
            videoControl.progressHeight = 100
            videoTitleBar.videoTitleHeight = 80
            videoControl.opacity = 1;  // 修改透明度为1
            videoTitleBar.opacity = 1;
            // 鼠标光标正常
            mouseArea.cursorShape = "ArrowCursor"
            hideProgressBarTimer.restart();
        }

    }

    // 隐藏进度条的计时器，隐藏鼠标计时器
    Timer {
        id: hideProgressBarTimer
        interval: 1200  // 1s后自动隐藏
        running: false
        repeat: false
        onTriggered: {
            videoControl.progressHeight = 0
            videoTitleBar.videoTitleHeight = 0
            videoControl.opacity = 0;  // 修改透明度为0，即完全透明
            videoTitleBar.opacity = 0;
            // 鼠标光标为空
            mouseArea.cursorShape = "BlankCursor"
        }
    }

    //小电视图标
    Image {
        id: imagerForStart
        source: "qrc:/assets/icon/play.png"
        anchors {
            right: parent.right
            rightMargin: 35
            bottom: parent.bottom
            bottomMargin: 100
        }

        width: 80
        height: 80

        opacity: 0.7  // 默认透明度为0.7
        Behavior on opacity {  // 添加动画行为
            OpacityAnimator { duration: 100 }
        }
    }

    // 弹幕显示区域
    Rectangle{
        id : bullet
        height: 30
        y: 200
//        property alias textstr: roottext.text
//        Text {
//            id : roottext
//            color: Qt.rgba(Math.random()+0.1,Math.random()+0.05,Math.random(),1);
//            font.pointSize: 15
//        }
        NumberAnimation on x{
            from : 0
            to : window.width
            duration:5000
            onStopped: bullet.destroy(1)
        }

    }

    //Subtitle Area
    Text{
        id : subtitleText
        text: subProvider.subText
        color: "#ffffff"
        font.pixelSize: 25
        font.bold :true

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: videoControl.top
            bottomMargin: 20
        }

    }



    // 播放开始
    function videoPlay() {
        player.play();
    }

    // 播放暂停
    function videoPause() {
        player.pause();
    }

    // 停止播放
    function videoStop() {
        player.stop();
    }

    // 单击事件
    function singleClick() {
        if(!bRunning) {
            videoPlay()
        }else{
            videoPause()
        }
        bShowPlayIcon()
    }

    // 双击事件
    function dblClick() {
        if (bFullSreen === true) {
            window.visibility = Window.Windowed
            bFullSreen = false
            videoControl.changeFullScreenIcon()
        } else {
            window.visibility = Window.FullScreen
            bFullSreen = true
            videoControl.changeFullScreenIcon()
        }
    }

    // 是否显示播放按钮
    function bShowPlayIcon() {
        if (bRunning) {
            imagerForStart.opacity = 0
        } else {
            imagerForStart.opacity = 0.7
        }
    }

}
