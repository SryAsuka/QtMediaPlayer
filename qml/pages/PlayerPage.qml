/**
 * 作者：范榆康
 * 日期：2023.6.13
 * 播放页面
 */
import QtQuick
import QtQuick.Controls
import QtMultimedia
import "../components"

Rectangle {

    property alias video: video
    property alias player: player
    // 是否全屏
    property bool bFullSreen: false

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
        source: "file:///run/media/root/坠梦之盘/作品集/视频/鬼畜.mp4"
        videoOutput: video
    }

    // 加载VideoControl视频控制组件
    VideoControl {
        id: videoControl
        anchors.bottom: parent.bottom

        player: player
        hideTimer: starButton.hideTimer
        bFullSreen: playerPage.bFullSreen

        // 出现设置
        opacity: 0  // 默认透明度为0，即完全透明
        Behavior on opacity {  // 添加动画行为
            OpacityAnimator { duration: 300 }
        }
    }

    // 加载VideoTitleBar视频标题组建
//    VideoTitleBar {
//        id: videoTitleBar
//        anchors.top: parent.top
//    }

    // 屏幕中间的播放按钮，点击一下视频暂停图标显示，再点击视频播放图标隐藏
    Rectangle{
        id:starButton
        anchors {
            fill: parent
            bottomMargin: videoControl.progressHeight
        }

        anchors.centerIn: parent
        color: "transparent"
        MouseArea{
            anchors.fill: parent

            // 避免双击/单击事件同时触发
            acceptedButtons: Qt.LeftButton | Qt.RightButton
                property alias oneClickThreshold:timer.interval
                Timer{
                    id:timer
                    interval: 200
                    onTriggered: singleClick()   //计时超时，触发单击事件
                }
                onClicked: {
                    if(mouse.button == Qt.RightButton) {
                        if(timer.running)   //在阈值时间内发生第二次点击
                        {
                            dblClick()   //触发双击事件
                            timer.stop()   //停止计时，直到下一次点击
                        }
                        else
                            timer.restart()    //此次点击前没有计时，启动计时
                    }
                }

            // 判断视频播放状态，点击时，不是播放状态就进行播放，播放状态就暂停
            onClicked: {
                if(player.playbackState !== MediaPlayer.PlayingState){
                    videoPlay()
                    imagerForStart.opacity = 0
                }else{
                    videoPause()
                    imagerForStart.opacity = 0.7
                }
            }

            onDoubleClicked: {
                if (bFullSreen === true) {
                    mainWindow.visibility = Window.Windowed

                    bFullSreen = false
                } else {
                    mainWindow.visibility = Window.FullScreen
                    bFullSreen = true
                }
            }
        }
        Image {
            id: imagerForStart
            source: "qrc:/assets/icon/play.png"
            anchors {
                right: parent.right
                rightMargin: 35
                bottom: parent.bottom
                bottomMargin: 10
            }

            width: 80
            height: 80

            opacity: 0.7  // 默认透明度为0.7
            Behavior on opacity {  // 添加动画行为
                OpacityAnimator { duration: 100 }
            }
        }

        // 鼠标监听区域,实现鼠标移动视频控制组件出现
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true  // 启用鼠标悬停
            propagateComposedEvents: true

            // 鼠标移动时显示进度条和播放/暂停按钮，并启动计时器
            onPositionChanged: {
                videoControl.opacity = 1;  // 修改透明度为1，即完全不透明
                hideProgressBarTimer.restart();
            }      

            Behavior on opacity {  // 添加动画行为
                OpacityAnimator { duration: 300 }
            }
        }

        // 隐藏进度条的计时器
        property Timer hideTimer: Timer {
            id: hideProgressBarTimer
            interval: 1000  // 1s后自动隐藏
            running: false
            repeat: false
            onTriggered: {
                videoControl.opacity = 0;  // 修改透明度为0，即完全透明
            }
        }
    }

    function videoPlay() {
        player.play();
    }

    function videoPause() {
        player.pause();
    }

    function videoStop() {
        player.stop();
    }


}
