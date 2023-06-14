/**
 * 作者：范榆康
 * 功能：实现弹幕
 * 2023.6.14，添加弹幕按钮样式
 */
import QtQuick
import QtQuick.Controls

Item {
    property Timer hideTimer
    // 弹幕是否开启，默认开启
    property bool bBullet: true
    height: 30
    width: 700

    Item {
        id: bulletBar
        anchors.fill: parent

        // 关闭/开启弹幕
        Button {
            id: bulletControl
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
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
            icon.source: bBullet ? "qrc:/assets/icon/bulletOn.png" : "qrc:/assets/icon/bulletOff.png"
            icon.height: 30
            icon.width: 30
            ToolTip.visible: hovered
            ToolTip.text: bBullet ? "关闭弹幕" : "开启弹幕"

            onClicked: {
                bBullet = !bBullet
            }
        }

        // 弹幕设置
        Button {
            id: bulletSetting
            anchors {
                verticalCenter: parent.verticalCenter
                left: bulletControl.right
                leftMargin: 8
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
            icon.source: "qrc:/assets/icon/bulletSetting.png"
            icon.height: 30
            icon.width: 30

            onClicked: {
                // 弹幕设置
            }
        }

        // 弹幕输入条
        Rectangle {
            id: bulletInputRect
            width: 500
            height: 30
            color: "#80808080"
            anchors {
                verticalCenter: parent.verticalCenter
                left: bulletSetting.right
                leftMargin: 8
            }

            TextInput {
                id: bulletInput
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                }

                property string placeholderText: "发个友善的弹幕见证下"

                text: placeholderText
                // 设置字体样式
                font.pixelSize: 18
                font.family: "微软雅黑"
                font.weight: Font.Medium

                color: "#bbbbbb"
                opacity: 0.7

                onActiveFocusChanged: {
                    if (activeFocus) {
                        hideTimer.stop()
                    } else {
                        hideTimer.start()
                    }
                }
            }

            // 当鼠标在输入框内，不隐藏进度条
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true  // 启用鼠标悬停
                propagateComposedEvents: true
                onPressed: mouse.accepted = false

                onEntered: {
                    hideTimer.stop()
                }
                onExited: {
                    hideTimer.start()
                }

            }
        }

        // 发送按钮
        Button {
            width: 50
            height: 30
            anchors {
                verticalCenter: parent.verticalCenter
                left: bulletInputRect.right
            }

            contentItem: Text {
                anchors {
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                    topMargin: 5
                }

                text: "发送"
                color: "white"
                font.pixelSize: 15
            }

            onClicked: {
                if (bulletInput.text !== "") {
                    console.log("Bullet: " + bulletInput.text);
                    bulletInput.text = "";
                }
            }

            background: Rectangle {
                color: "#1195db"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true  // 启用鼠标悬停
                    propagateComposedEvents: true
                    onPositionChanged: {
                        hideTimer.stop()
                    }

                }
            }
        }
    }

}
