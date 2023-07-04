/**
 * 作者：范榆康
 * 功能：实现弹幕
 * 2023.6.14，添加弹幕按钮样式
 */
import QtQuick
import QtQuick.Controls
import QtQml.XmlListModel

Item {
    id: bullectscreenComponent

    property alias bulletSettingButton: bulletSetting

    property Timer hideTimer
    // 弹幕是否开启，默认开启
    property bool bBullet: true

    property int textSize

    property color textColor

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

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }

            // 图标设置
            icon.source: bBullet ? "qrc:/assets/icon/bulletOn.png" : "qrc:/assets/icon/bulletOff.png"
            icon.color: bBullet ? globalButtonColor : "#f3f3f3"
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

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            hideTimer.stop()
                            hideBullectSettingTimer.stop()
                            bullectSettingComponent.width = 150
                            bullectSettingComponent.height = 120
                        }
                        else {
                            hideTimer.start()
                            hideBullectSettingTimer.start()
                        }
                    }
                }
            }

            // 图标设置
            icon.source: "qrc:/assets/icon/bulletSetting.png"
            icon.height: 30
            icon.width: 30
            ToolTip.visible: hovered
            ToolTip.text: "弹幕设置"

            // 隐藏弹幕设置的计时器
            Timer {
                id: hideBullectSettingTimer
                interval: 1200  // 1s后自动隐藏
                repeat: false
                onTriggered: {
                    bullectSettingComponent.height = 0
                    bullectSettingComponent.width = 0
                }
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
                font.family: window.mFONT_FAMILY
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
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) { hideTimer.stop() }
                    else { hideTimer.start() }
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
                    sendDanmu()
                    bulletInput.text = "";
                }
            }

            background: Rectangle {
                color: globalButtonColor

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) { hideTimer.stop() }
                        else { hideTimer.start() }
                    }
                }
            }
        }

        // 加载弹幕设置BullectSettingDrawer组件
        BullectSettingDrawer {
            id: bullectSettingComponent
        }
    }

    function sendDanmu() {
        textSize = videoPlayer.bullectSettingDrawer.textSize
        textColor = videoPlayer.bullectSettingDrawer.textColor

        var timestamp
        var millseconds = player.position
        var minutes = Math.floor(millseconds / 60000)
        millseconds -= minutes * 60000
        var seconds = millseconds / 1000
        seconds = Math.round(seconds)
        // 返回 mm : ss 格式时间
        if(minutes < 10 & seconds < 10)
            timestamp =  "0" + minutes + ":0" + seconds
        else if(minutes >= 10 & seconds < 10)
            timestamp =  minutes + ":0" + seconds
        else if(minutes < 10 & seconds >= 10)
            timestamp =  "0" + minutes + ":" + seconds
        else    timestamp =  minutes + ":" + seconds

        bulletxml.saveDanmu(timestamp, bulletInput.text, textSize, textColor)
        // Add danmu to the ListView
        //videoPlayer.danmuModel.append({"content": content, "fontsize": 20, "color": "white"});
    }
}
