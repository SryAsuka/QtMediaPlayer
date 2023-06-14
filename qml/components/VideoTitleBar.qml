/**
 * 作者：范榆康
 * 功能：视频标题栏，返回按钮，显示标题，收藏按钮
 * 2023.6.14，视频标题栏
 */
import QtQuick
import QtQuick.Controls
import QtMultimedia
import "../pages"

// 视频标题栏
Item {
    id: videoTitleItem

    width: parent.width
    height: parent.height

    Rectangle {
        id: videoTitleBar
        height: 80
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        // 出现设置
        opacity: 0  // 默认透明度为0，即完全透明
        Behavior on opacity {  // 添加动画行为
            OpacityAnimator { duration: 300 }
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

}
