/**
 * 视频热门视频组件
 */

import QtQuick
import QtQuick.Controls

Item{

    property alias list: gridRepeater.model

    Grid {
        id: gridLayout
        anchors.fill: parent
        columns: 5
        Repeater {
            id: gridRepeater
            Frame {
                padding: 5
                width: parent.width * 0.2
                height: parent.width * 0.2 + 30
                background: Rectangle {
                    id:background
                    color: "#00000000"
                }
                clip: true

                VideoDisplayComponent {
                    id: img
                    width: parent.width
                    height: parent.width
                    //imgSrc: modelData.coverImgUrl

                }

                Text {
                    anchors {
                        top: img.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: modelData.name
                    font.family: window.mFONT_FAMILY
                    height: 30
                    elide: Qt.ElideMiddle
                }


                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        background.color = "#50000000"
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                }
            }
        }
    }
}
