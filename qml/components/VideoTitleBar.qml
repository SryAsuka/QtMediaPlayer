/**
 * 作者：范榆康
 * 功能：视频标题栏，返回按钮，显示标题，收藏按钮
 * 2023.6.14，视频标题栏
 * 2023.6.15下午：添加收藏、返回、文件列表按钮
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

    width: parent.width
    height: videoTitleHeight

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
            // 实现返回
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
            font.family: "微软雅黑"
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
        ToolTip.text: "文件列表"

        onClicked: {
            // 实现文件列表打开
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

}
