/**
 * 作者：范榆康
 * 功能：视频标题栏，返回按钮，显示标题，收藏按钮
 * 2023.6.14，视频标题栏
 * 2023.6.15下午：添加收藏、返回、文件列表按钮
 * 2023.6.16下午：增加鼠标移动区域
 */
import QtQuick
import QtQuick.Controls
import QtMultimedia
import "../pages"

// 视频标题栏
Rectangle {
    id: videoTitleItem
    property int videoTitleHeight: 0
    property Timer hideTimer
    z:100

    property alias dVideoTitle: videoTitleText

    width: parent.width
    height: videoTitleHeight

    // 鼠标拖动
    Item {
        anchors {
            fill: parent
            rightMargin: 10
        }
        PointHandler {
            acceptedDevices: PointerDevice.Mouse
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.CrossCursor

            onActiveChanged: setPoint(point.position.x, point.position.y)

            onPointChanged: {
                if (active) {
                    moveX(point.position.x)
                    moveY(point.position.y)
                }
            }
        }
    }

    // 鼠标缩放区域
    Rectangle {
        id: topRightCorner
        width: 10
        height: 10
        anchors.top: parent.top
        anchors.right: parent.right
        color: "transparent"

        PointHandler {
            property real startX: 0
            property real startY: 0

            acceptedDevices: PointerDevice.Mouse
            acceptedButtons: Qt.LeftButton

            onActiveChanged: {
                if (active) {
                    startX = point.position.x
                    startY = point.position.y
                }
            }

            onPointChanged: {
                if (active) {
                    window.width += point.position.x - startX;
                    window.height -= point.position.y - startY;
                    window.y += point.position.y - startY;
                }
            }
        }

        HoverHandler { cursorShape: Qt.SizeBDiagCursor }
    }

    // 返回按钮
    Button {
        id: returnButton
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
        icon.source: "qrc:/assets/icon/return.png"
        icon.height: 30
        icon.width: 30
        ToolTip.visible: hovered
        ToolTip.text: "返回"

        onClicked: {
            window.changePageForHome()
            videoPlayer.playFileList.close()

        }
    }

    // 视频标题栏
    Rectangle {
        id: videoTitle
        color: "transparent"
        anchors {
            verticalCenter: parent.verticalCenter
            left: returnButton.right
            leftMargin: 30
        }

        Text {
            id: videoTitleText
            text: ""
            font.bold: true
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }

            color: "white"
            font.pixelSize: 22
            font.weight: Font.Thin
            font.family: window.mFONT_FAMILY
            opacity: 0.8
        }
    }

    // 收藏按钮
    Button {
        id: collectButton
        anchors {
            verticalCenter: parent.verticalCenter
            right: fileListButton.left
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
        icon.source: bCollect ? "qrc:/assets/icon/collectOn.png" : "qrc:/assets/icon/collectOff.png"
        icon.height: 30
        icon.width: 30
        ToolTip.visible: hovered
        ToolTip.text: bCollect ? "取消收藏" : "收藏"

        onClicked: {
            // 实现收藏

            videoPlayer.playFileList.close()
            if (bCollect) {
                bCollect = false
            } else {
                bCollect = true
            }
        }
    }

    // 文件列表
    Button {
        id: fileListButton
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
        icon.source:"qrc:/assets/icon/fileList.png"
        icon.height: 30
        icon.width: 30
        ToolTip.visible: hovered
        ToolTip.text: "播放列表"

        onClicked: {
            if( !videoPlayer.playFileList.opened){
                videoPlayer.playFileList.open()
            }else{
                videoPlayer.playFileList.close()
                console.log("close")
            }
        }
    }

    // 设置背景渐变效果
    gradient: Gradient {
       GradientStop {
           position: 1.0
           color: "transparent"
       }
       GradientStop {
           position: 0.2
           color: Qt.rgba(0, 0, 0, 0.8)
       }
    }

    // 移动窗口
    function moveX( mouseX = 0 ) {
        var x = window.x + mouseX-point.x
        if(x<-(window.width-70)) x = - (window.width-70)
        if(x>Screen.desktopAvailableWidth-70) x = Screen.desktopAvailableWidth-70
        window.x = x
    }

    function moveY( mouseY = 0 ) {
        var y = window.y + mouseY-point.y
        if(y<=0) y = 0
        if(y>Screen.desktopAvailableHeight-70) y = Screen.desktopAvailableHeight-70
        window.y = y
    }

    function setPoint ( mouseX =0 ,mouseY = 0) {
        point = Qt.point(mouseX,mouseY)
//        console.log(mouseX,mouseY)
    }

}
