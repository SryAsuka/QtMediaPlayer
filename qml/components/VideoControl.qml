/**
 * 作者：范榆康
 * 功能：进度条等视频控制的功能组件
 * 2023.6.13，添加进度条以及两侧的时间显示
 * 2023.6.14上午：增加滑块样式
 * 2023.6.14下午：增加进度条拖动功能
 */
import QtQuick
import QtQuick.Controls
import QtMultimedia
import "../pages"

// 视频控制区域
Item {
    id: videoControl
    property int progressHeight: 80
    property MediaPlayer player
    property Timer hideTimer
    readonly property bool bRunning: player.playbackState

    width: parent.width
    height: progressHeight

    Item{
        y:0
        width: parent.width
        height: parent.height/2
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                icon.source: "qrc:/assets/icon/close.png"
                ToolTip.visible: hovered
                ToolTip.text: qsTr("后退30秒")
                onClicked: {
                    console.log("8888")
                }
            }

        }
     }
    // 进度条区域
    Rectangle {
        id: progressRow
        height: progressHeight
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        // 进度条/滑块
        Slider {
            id: progressBar
            // 设置进度条锚点
            anchors {
                top: parent.top
                topMargin: 20
                left: durationTime.right
                leftMargin: 20
                right: endTime.left
                rightMargin: 20
            }

            from: 0
            to: player.duration
            value: player.position

            // 设置进度条的背景样式
            background: Rectangle {
                x: progressBar.leftPadding
                y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                implicitHeight: 3
                implicitWidth: 200
                width: progressBar.availableWidth
                height: implicitHeight
                radius: 2

                // 设置进度条背景颜色
                color: "#F0F0F0"

                // 视频已经播放的区域
                Rectangle {
                    width: progressBar.visualPosition * progressBar.width
                    height: parent.implicitHeight
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 2

                    // 进度条已经走完的颜色
                    color: "#7795ee"
                }
            }

            // 滑块样式
            handle: Rectangle {
                antialiasing: true
                x: progressBar.leftPadding + progressBar.visualPosition
                                       * (progressBar.availableWidth - width)
                y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                implicitWidth: 29
                implicitHeight: 29
                radius: 10
                border.color: "#bdbebf"    // 滑块边框颜色
                // 判断滑块按压状态，设置不同的颜色
                color: progressBar.pressed ? "#B0C4DE" : "#F0F0F0"
                // 滑块中心的区域，我这里设置了透明
                Rectangle {
                    width: 4
                    height: 4
                    radius: 2
                    color: "transparent"
                    anchors.centerIn: parent
                }
            }

            // 进度条拖放功能
            onValueChanged: {
                if (pressed) {
                    player.position = value
                }
            }

            // 当进度条在拖放时，不要启动隐藏计时器
            onPressedChanged: {
                if (pressed) {
                    hideTimer.stop()
                } else {
                    hideTimer.restart()
                }
            }
        }

        // 播放时间
        Text {
            id:durationTime
            anchors {
                verticalCenter: progressBar.verticalCenter
                left: parent.left
                leftMargin: 30
            }
            color: "#ffffff"    // 字体颜色
            // 字体属性，字号 字体 宽度
            font {
                pointSize: 12
                family: "微软雅黑"
                weight: Font.Medium
            }
            // 显示当前播放时间
            text: {
                // 创建变量获取时间当前播放位置，单位毫秒
                var milliseconds = player.position
                // 创建变量，将当前播放位置的毫秒转换为分钟，并向下取舍
                var minutes = Math.floor(milliseconds / 60000)
                // 获取不足 60秒的毫秒数
                milliseconds -= minutes * 60000
                // 创建变量，不足60秒的毫秒数转换为秒
                var seconds = milliseconds / 1000
                // 进行四舍五入
                seconds = Math.round(seconds)
                // 判断秒数是否小于10秒，来输出时间格式，最终格式为：mm:ss
                if(minutes < 10 & seconds < 10)
                    return "0" + minutes + ":0" + seconds
                else if(minutes >= 10 & seconds < 10)
                    return minutes + ":0" + seconds
                else if(minutes < 10 & seconds >= 10)
                    return "0" + minutes + ":" + seconds
                else    return minutes + ":" + seconds
            }
        }

        // 进度条右侧，显示视频总时长
        Text {
            id: endTime
            anchors {
                verticalCenter: progressBar.verticalCenter
                right: parent.right
                rightMargin: 30
            }
            color: "#ffffff"
            font {
                pointSize: 12
                family: "微软雅黑"
                weight: Font.Medium
            }
            text: {
                var millseconds = player.duration
                var minutes = Math.floor(millseconds / 60000)
                millseconds -= minutes * 60000
                var seconds = millseconds / 1000
                seconds = Math.round(seconds)
                // 返回 mm : ss 格式时间
                if(minutes < 10 & seconds < 10)
                    return "0" + minutes + ":0" + seconds
                else if(minutes >= 10 & seconds < 10)
                    return minutes + ":0" + seconds
                else if(minutes < 10 & seconds >= 10)
                    return "0" + minutes + ":" + seconds
                else    return minutes + ":" + seconds
            }
        }

        // 下方播放、弹幕区域
        Row {
            anchors {
                top: progressBar.bottom
                left: parent.left
                right: parent.right
            }

            // 播放按钮
            Button {
                icon.source: bRunning ? "qrc:/assets/icon/start.png" : "qrc:/assets/icon/start.png"
                ToolTip.visible: hovered
                ToolTip.text: bRunning ? "暂停" : "开始"
                onClicked: {
                    if(!bRunning){
                        player.play()
                    } else {
                        player.pause()
                    }
                }
            }
        }

        // 设置背景渐变效果
        gradient: Gradient {
           GradientStop {
               position: 0.2
               color: "transparent"
           }
           GradientStop {
               position: 1.0
               color: Qt.rgba(0, 0, 0, 0.8)
           }
        }
    }
}

