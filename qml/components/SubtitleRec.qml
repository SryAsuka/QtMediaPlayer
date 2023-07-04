/**
 *  To open the subtitleRec
 *  Author: SryAsuka
 *  Data: 2023.6
**/

import QtQuick
import QtQuick.Controls 2.15
import QtCore
import QtQuick.Dialogs
import QtQuick.Layouts

Rectangle {
    id: subtitle

    property alias sSubList: subList

    width: 0
    height: 0
    color : "#ffffff"

    Behavior on width {
        NumberAnimation { duration: 80 }
    }
    Behavior on height {
        NumberAnimation { duration: 80 }
    }



    anchors.left: subtitleButton.left
    anchors.leftMargin: -80
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

            highlight:Rectangle {
                    color: globalButtonColor
                    radius: 5
                    opacity: 0.8
                }



            highlightMoveDuration: 100
            highlightMoveVelocity: -1

            footer: Rectangle{
                id: subListFooter
                width: parent.width

                height: 50
                radius: 5
                color: "transparent"


                    RowLayout{
                        anchors.fill: parent

                        Label{

                            text: "Open Other Subtitle"
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            font.bold: true

                            layer.enabled: true
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            elide: Text.ElideRight
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                            TapHandler{
                                onTapped: subOpenDialog.open()
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
                        bCaptionOn = true

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

    FileDialog{
        id:subOpenDialog
        title: "Select a Subtitle files"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFile
        nameFilters: [ "Subtitle files (*.srt *.ass)" ]
        onAccepted: {
            mainPlaylist.appendSubFile(playFileList.playListView.currentIndex,selectedFile)
            subList.model = mainPlaylist.subFilePaths(playFileList.playListView.currentIndex)
        }
    }
}
