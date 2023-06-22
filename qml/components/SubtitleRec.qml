/**
 *  To open the subtitleRec
 *  Author: SryAsuka
 *  Data: 2023.6
**/

import QtQuick
import QtQuick.Controls 2.15
import QtCore
import QtQuick.Layouts

Rectangle {
    id: subtitle

    width: 0
    height: 0
    color : "#ffffff"

    anchors.right: subtitleButton.right
    anchors.rightMargin: -60
    y:-180
    radius: 5
    clip: true

    ScrollView{
        id : subtitleFileScrollView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        ListView {

            clip: true

            id: subList
            anchors.fill: parent



            model: mainPlaylist.subFilePaths(playFileList.playListView.currentIndex)
            delegate: subListdelegate
            highlight:
                Rectangle {
                    color: globalButtonColor
                    radius: 5
                    opacity: 0.8
                }
            highlightMoveDuration: 100
            highlightMoveVelocity: -1

            footer: ItemDelegate{
                id: subListFooter
                width: parent.width
                height: 50


                Rectangle{
                    anchors.fill: parent
                    color: "transparent"

                    RowLayout{
                        anchors.fill: parent

                        Label{

                        text: "Open Other"
                        horizontalAlignment: Qt.AlignCenter
                        verticalAlignment: Qt.AlignVCenter
                        font.bold: true

                        layer.enabled: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                        }

                        Label{

                        text: "Close Subtitle"
                        horizontalAlignment: Qt.AlignCenter
                        verticalAlignment: Qt.AlignVCenter
                        font.bold: true

                        layer.enabled: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                        MouseArea{
                            id:mouseArea
                            anchors.fill: parent
                            onClicked: {
                                subProvider.selectedSubFile("null.null");
                                subList.currentIndex = -1
                            }
                        }

                        }
                    }
                }

            }
        }

        Component{
            id:subListdelegate

            Item{

                id: subListItem
                width: parent.width
                height: 50

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"

                    RowLayout{
                        anchors.fill: parent

                        Label{

                        text: modelData.split('/').pop()
                        horizontalAlignment: Qt.AlignCenter
                        verticalAlignment: Qt.AlignVCenter
                        font.bold: true

                        layer.enabled: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                        }
                    }
                }
                MouseArea{
                    id:mouseArea

                    anchors.fill: parent

                    onClicked: {
                        subList.currentIndex = index
                        subProvider.selectedSubFile(modelData);
                    }
                }
            }
        }
    }

    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                hideTimer.stop()
                hideSubtitleTimer.stop()
            }
            else {
                hideTimer.start()
                hideSubtitleTimer.start()
            }
        }
    }
}
