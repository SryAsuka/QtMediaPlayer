/**
 * 作者：范榆康
 * 功能：进度条等视频控制的功能组件
 * 2023.6.13，添加进度条以及两侧的时间显示
 * 2023.6.14上午：增加滑块样式
 * 2023.6.14下午：增加进度条拖动功能
 * 2023.6.15上午：实现全屏
 *
 *  fix the bug
 *  Author: SryAsuka
 *  Data: 2023.6
 *
 */
import QtQuick
import QtQuick.Controls
import QtMultimedia
import "../pages"

// 视频控制区域
Rectangle {
    id: videoControl
    z:100

    property alias subtitleButton: captionButton

    property int progressHeight: 0
    property MediaPlayer player
    property Timer hideTimer
    property BulletscreenComponent bulletscreenComponent

    // 播放速度
    property double videoSpeed: 1

    width: parent.width
    height: progressHeight

    // 进度条区域
    Rectangle {
        id: progressRow
        height: progressHeight
        color: "transparent"
        anchors {
            bottom: controlButton.top
            left: parent.left
            right: parent.right
        }

        // 进度条/滑块
        Slider {
            id: progressBar
            // 设置进度条锚点
            anchors {
                bottom: parent.bottom
                topMargin: 30
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
                    color: globalButtonColor
                }
            }

            // 滑块样式
            handle: Rectangle {
                antialiasing: true
                x: progressBar.leftPadding + progressBar.visualPosition
                                       * (progressBar.availableWidth - width)
                y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                implicitWidth: 15
                implicitHeight: 15
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
    }

    // 下方播放、弹幕区域
    Item {
        id: controlButton

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 60

        // 后退按钮
        Button {
            id: upButton
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 30
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }

            // 图标设置
            icon.source: "qrc:/assets/icon/up.png"
            icon.height: 25
            icon.width: 25
            ToolTip.visible: hovered
            ToolTip.text: "后退"

            onClicked: {
                player.position -= 3000
            }
        }

        // 播放按钮
        Button {
            id: playButton
            anchors {
                verticalCenter: parent.verticalCenter
                left: upButton.right
                leftMargin: 30
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }

            // 图标设置
            icon.source: bRunning ? "qrc:/assets/icon/pause.png" : "qrc:/assets/icon/start.png"
            icon.height: 30
            icon.width: 30
            ToolTip.visible: hovered
            ToolTip.text: bRunning ? "暂停" : "开始"

            onClicked: {
                if(!bRunning){
                    player.play()
                    bShowPlayIcon()
                } else {
                    player.pause()
                    bShowPlayIcon()
                }
            }
        }

        // 快进按钮
        Button {
            id: nextButton
            anchors {
                verticalCenter: parent.verticalCenter
                left: playButton.right
                leftMargin: 30
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }

            // 图标设置
            icon.source: "qrc:/assets/icon/next.png"
            icon.height: 25
            icon.width: 25
            ToolTip.visible: hovered
            ToolTip.text: "快进"

            onClicked: {
                player.position += 3000
            }
        }

        // 弹幕条
        BulletscreenComponent {
            id: bulletscreenComponent
            hideTimer: videoControl.hideTimer
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        // 倍速按钮
        Button {
            id: videoSpeedButton
            anchors {
                verticalCenter: parent.verticalCenter
                right: volumeButton.left
                rightMargin: 20
            }

            contentItem: Text {
                id: videoSpeedText
                text: "x1"
                color: "white"
                font.pixelSize: 18
                font.weight: Font.Bold
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }

            // 图标设置
            icon.source: "qrc:/assets/icon/next.png"

            ToolTip.visible: hovered
            ToolTip.text: qsTr("播放速度")
            onClicked: {
                if(videoSpeed == 1){
                    videoSpeed  = 1.5
                    videoSpeedText.text = "x1.5"
                }
                else if(videoSpeed  == 1.5){
                    videoSpeed  = 2
                    videoSpeedText.text = "x2"
                }
                else if(videoSpeed  == 2){
                    videoSpeed  = 2.5
                    videoSpeedText.text = "x2.5"
                }
                else if(videoSpeed  == 2.5){
                    videoSpeed  = 1
                    videoSpeedText.text = "x1"
                }
                player.setPlaybackRate(videoSpeed)
            }
        }

        // 字幕按钮
        Button {
            id: captionButton
            anchors {
                verticalCenter: parent.verticalCenter
//                right: videoSpeedButton.left
                left: bulletscreenComponent.right
                leftMargin: -15
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { 
                            videoPlayer.playFileList.close()
                            hideTimer.stop()
                            hideSubtitleTimer.stop()
                            subtitleRec.width = 180
                            subtitleRec.height = 160
                            subtitleRec.sSubList.model =  mainPlaylist.subFilePaths(playFileList.playListView.currentIndex)
                        }
                        else {
                            hideTimer.start()
                            hideSubtitleTimer.start()
                        }
                    }
                }
            }

            // 图标设置
            icon.source: bCaptionOn ? "qrc:/assets/icon/captionOn.png" : "qrc:/assets/icon/captionOff.png"
            icon.color: bCaptionOn ? globalButtonColor : "#f3f3f3"
            icon.height: 35
            icon.width: 35
            ToolTip.visible: hovered
            ToolTip.text: bCaptionOn ? "关闭字幕" : "开启字幕"

            onClicked: {
                if(bCaptionOn){
                    bCaptionOn = false
                    subProvider.selectedSubFile("null.null");
                    subtitleRec.sSubList.currentIndex = -1
                } else {
                    bCaptionOn = true
                    subtitleRec.sSubList.currentIndex = 0
                    subProvider.selectedSubFile(mainPlaylist.setDefaultSub(playFileList.playListView.currentIndex));
                }

            }
            // 隐藏字幕的计时器
            Timer {
                id: hideSubtitleTimer
                interval: 1200  // 1.2s后自动隐藏
                repeat: false
                onTriggered: {
                    subtitleRec.height = 0
                    subtitleRec.width = 0
                }
            }
        }

        // 音量按钮
        Button {
            id: volumeButton

            anchors {
                verticalCenter: parent.verticalCenter
                right: settingButton.left
                rightMargin: 20
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            videoPlayer.playFileList.close()
                            hideTimer.stop()
                            hideVolumeTimer.stop()
                            volumeRec.height = 120
                            volumeRec.width = 40
                        }
                        else {
                            hideTimer.start()
                            hideVolumeTimer.start()
                        }
                    }
                }
            }

            // 图标设置
            icon.source: "qrc:/assets/icon/volume.png"
            icon.height: 30
            icon.width: 30

            onClicked: {
                volumeButton.icon.source = "qrc:/assets/icon/volumeMute.png"
                volumeSlider.value = 0
            }

            // 隐藏音量条的计时器
            Timer {
                id: hideVolumeTimer
                interval: 1200  // 1.2s后自动隐藏
                repeat: false
                onTriggered: {
                    volumeRec.height = 0
                    volumeRec.width = 0
                }
            }
        }

        // 设置按钮
        Button {
            id: settingButton
            anchors {
                verticalCenter: parent.verticalCenter
                right: fullScreenButton.left
                rightMargin: 20
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true  // 启用鼠标悬停
                    propagateComposedEvents: true
                    onPositionChanged: {
                        hideTimer.stop()
                    }

                    onEntered: {
                        settingButton.rotation = 0
                        rotateAnimation.start()
                    }

                }
            }

            NumberAnimation {
                id: rotateAnimation
                target: settingButton
                property: "rotation"
                from: 0
                to: 180
                duration: 500
            }

            // 图标设置
            icon.source: "qrc:/assets/icon/setting.png"
            icon.height: 28
            icon.width: 28
            ToolTip.visible: hovered
            ToolTip.text: "设置"

            onClicked: {
                // 实现设置
            }
        }

        // 全屏/缩小按钮
        Button {
            id: fullScreenButton
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 30
            }

            opacity: 0.8    // 设置透明度
            // 设置背景为透明
            background: Rectangle {
                color: "transparent"

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }

            // 图标设置
            icon.source: bFullSreen ? "qrc:/assets/icon/videoMin.png" : "qrc:/assets/icon/videoMax.png"
            icon.height: 30
            icon.width: 30
            ToolTip.visible: hovered
            ToolTip.text: bFullSreen ? "退出全屏" : "进入全屏"

            onClicked: {
                if (bFullSreen === true) {
                    window.visibility = Window.Windowed
                    bFullSreen = false
                } else {
                    window.visibility = Window.FullScreen
                    bFullSreen = true
                }
                changeFullScreenIcon()
            }
        }

        //音量条弹窗部分
        Rectangle{
            id : volumeRec

            //anchors
            width: 0
            height: 0
            color: "#ffffff"
            anchors.left: volumeButton.left
            anchors.leftMargin: -5
            radius: 5
            y:-140

            Behavior on width {
                NumberAnimation { duration: 80 }
            }
            Behavior on height {
                NumberAnimation { duration: 80 }
            }

            Slider {
                id: volumeSlider

                anchors.verticalCenter: parent.verticalCenter

                anchors.horizontalCenter: parent.horizontalCenter
                // 音量条为竖的
                orientation: Qt.Vertical
                from: 0
                value: 50
                to: 100
                height: parent.height - 20

                // volumeSlider background
                background: Rectangle{
                    anchors.verticalCenter: parent.verticalCenter
                    x: volumeSlider.leftPadding + 5
                    color :  globalButtonColor
                    height: volumeSlider.availableHeight
                    width: implicitWidth
                    implicitWidth: 4
                    radius: 2

                    Rectangle{
                        height: volumeSlider.visualPosition * parent.height
                        width: parent.width
                        color: "#6a7a82"
                        radius: 2
                    }

                }

                // volumeSlider handle
                handle: Rectangle{
                    id: handler
                    x: volumeSlider.availableWidth / 2 - width / 2
//                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    y: volumeSlider.visualPosition * (volumeSlider.availableHeight - height)
                    implicitWidth: volumeSlider.height * 0.14
                    implicitHeight: volumeSlider.height * 0.14
                    border.color :  "#1195db"
                    border.width: (volumeSlider.pressed)? 1 : radius / 2
                    color:  "#f0f0f0"
                    scale: (volumeSlider.pressed) ? 1.1 : 1
                    radius: 7

                    Behavior on scale {
                        NumberAnimation { duration: 100 }
                    }

                    Behavior on border.width {
                        NumberAnimation { duration: 100 }
                    }
                }

                onValueChanged: {
                    player.audioOutput.volume = value / 100

                    if (player.audioOutput.volume === 0) {
                        volumeButton.icon.source = "qrc:/assets/icon/volumeMute.png"
                    } else {
                        volumeButton.icon.source = "qrc:/assets/icon/volume.png"
                    }
                }

                // 当进度条在拖放时，不要启动隐藏计时器，不要隐藏音量条
                onPressedChanged: {
                    if (pressed) {
                        hideTimer.stop()
                        hideVolumeTimer.stop()
                    } else {
                        hideTimer.restart()
                        hideVolumeTimer.restart()
                    }
                }
            }

            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        hideTimer.stop()
                        hideVolumeTimer.stop()
                    }
                    else {
                        hideTimer.start()
                        hideVolumeTimer.start()
                    }
                }
            }
        }

        SubtitleRec{
            id : subtitleRec

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

    // 更改全屏图标
    function changeFullScreenIcon() {
        if (bFullSreen) {
            fullScreenButton.icon.source = "qrc:/assets/icon/videoMin.png"
        } else {
            fullScreenButton.icon.source = "qrc:/assets/icon/videoMax.png"
        }
    }
}

