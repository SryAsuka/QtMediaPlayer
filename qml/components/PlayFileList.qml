/**
 * 作者：范榆康
 * 日期：2023.6.16
 * 播放列表弹窗
 */

import QtQuick
import QtQuick.Controls

Drawer {
    id: drawer
    width: parent.width / 4
    height: parent.height
    edge: Qt.RightEdge
    background: Rectangle {
        color: "#000000"
        opacity: 0.7
    }

//    Column {
//        spacing: 10
//        anchors.fill: prarent

//        // 关闭文件列表按钮
//        Button {

//            opacity: 0.8    // 设置透明度
//            // 设置背景为透明
//            background: Rectangle {
//                color: "transparent"
//            }

//            // 图标设置
//            icon.source:"qrc:/assets/icon/fileList.png"
//            icon.height: 30
//            icon.width: 30
//            ToolTip.visible: hovered
//            ToolTip.text: "播放列表"

//            onClicked: {
//                videoPlayer.playFileList.close()
//            }
//        }

        // 文件列表
        ListView {
            id: listView
            anchors.fill: parent
            model: ListModel {
                // 添加文件列表
                ListElement { name: "file1" }
                ListElement { name: "file2" }
                ListElement { name: "file3" }
                ListElement { name: "file4" }
            }

            delegate: Text {
                text: model.name
                font.pixelSize: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // 更改播放文件
                    }
                }
            }
        }
    }
//}
