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
    property int videoTitleHeight: 80
    property Timer hideTimer
//    z:100

    width: parent.width
    height: videoTitleHeight

    // 鼠标缩放区域
    Rectangle {
        id: topRightCorner
        width: 10
        height: 10
        anchors.top: parent.top
        anchors.right: parent.right
        color: "transparent"

        MouseArea {
            id: resizeMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.SizeBDiagCursor

            property real startX: 0
            property real startY: 0
            property int resizeMargin: 10

            onPressed: {
                startX = mouse.x
                startY = mouse.y
            }

            onPositionChanged: {
                if (resizeMouseArea.pressed) {
                    window.width += mouse.x - startX;
                    window.height -= mouse.y - startY;
                    window.y += mouse.y - startY;
                }
            }
        }
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true  // 启用鼠标悬停
                propagateComposedEvents: true
                onPositionChanged: {
                    hideTimer.stop()
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
            text: "视频标题"
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

    // 鼠标移动区域
    Item {
        anchors {
            left: videoTitle.right
            right: collectButton.left
            top: parent.top
            bottom: parent.bottom
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onPressed: setPoint(mouseX,mouseY)
            onMouseXChanged: moveX(mouseX)
            onMouseYChanged: moveY(mouseY)
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true  // 启用鼠标悬停
                propagateComposedEvents: true
                onPositionChanged: {
                    hideTimer.stop()
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true  // 启用鼠标悬停
                propagateComposedEvents: true
                onPositionChanged: {
                    hideTimer.stop()
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
            videoPlayer.playFileList.open()
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
