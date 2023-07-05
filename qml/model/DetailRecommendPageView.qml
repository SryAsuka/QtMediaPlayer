/*
*  To set recentList
*  Author: SryAsuka
*  Data: 2023.6
*/


import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import "../components"
import "../pages"


Item{

    id:detailView
    width: parent.width

    //mainpage
    Rectangle{
        id:mainPage

        width: parent.width
        height: 100
        color: "transparent"

        RowLayout{
            anchors.fill: parent

            Label{
                text:"Main Page"
                color: "Black"
                font.bold: true
                font.pointSize: 24
                Layout.leftMargin: 45
            }

            //open files
            Button{
                id : fileOpen
                height: 45


                icon.source:"qrc:/assets/icon/open.svg"
                icon.height: 25
                icon.width: 25
                text:"&Open File"
                font.bold:true
                font.pointSize: 12
                Layout.topMargin: 27.5
                Layout.bottomMargin: 27.5
                Layout.leftMargin: -75
                leftPadding:15
                rightPadding:15
                background: Rectangle {

                    color:globalButtonColor
                    radius: 8
                    opacity: 0.7
                }

                Layout.fillHeight: true

                onClicked: {
                    fileOpenDialog.open()
                }
            }
        }
    }

    FileDialog {
        id: fileOpenDialog
        title: "Select some video files"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFile
        nameFilters: [ "Video files (*.mkv *.mp4 *.avi)" ]
        onAccepted: {
            mainPlaylist.openFile(selectedFile)
            mainRecentlist.updateRecent(selectedFile)
            renecntScrollView.height = mainRecentlist.rowCount() > 0 ? 210 : 30
        }
    }

    ScrollView{
        id: renecntScrollView


        anchors.top: mainPage.bottom

        width: parent.width
        height: mainRecentlist.rowCount() > 0 ? 210 : 30
        clip: true

        //Recent Files
        GridView{

        id:recentView
        anchors.fill: parent

        interactive:false

        header:
            Label{
                text: "Recent Videos"
                horizontalAlignment: Qt.AlignCenter
                font.bold: true
                bottomPadding: 15
                font.pointSize: 18
            }

        model: mainRecentlist
        delegate: recentDelegate

        cellHeight: 180
        cellWidth: 200
        anchors.leftMargin: 45

        }


        Component{
        id:recentDelegate

            Item{

                Column{
                anchors.fill: parent

                Rectangle{
                    id:recentImageRec
                    width: recentView.cellWidth-20
                    height: recentView.cellHeight-60

                    radius: 5

                    layer.enabled: true
                    layer.effect: OpacityMask{
                        maskSource: Rectangle{
                            width:  recentImageRec.width
                            height: recentImageRec.height
                            radius: recentImageRec.radius
                        }
                    }

                    Image {
                        anchors.fill: parent
                        asynchronous: true
                        source: "image://recentlistTh/"+title
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        fillMode: Image.PreserveAspectCrop

                    }

                    HoverHandler{
                        onHoveredChanged:{
                            parent.scale = hovered ? 1.05 : 1.0
                        }
                    }

                    Behavior on scale {
                        NumberAnimation{
                            duration: 100
                        }
                    }

                    TapHandler{

                        onTapped: {
                            mainPlaylist.openFile("file://"+path)
                            mainRecentlist.updateRecent("file://"+path)

                        }
                    }

                }


                Label{
                    width: recentView.cellWidth-20
                    height: 40

                    text: title

                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    font.bold: true


                    elide: Text.ElideRight
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
            }
        }

    }


    ScrollView{
        id: recommendScrollView

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        anchors.top: renecntScrollView.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 10

        width: parent.width
        clip: true


        //Recommend Files
        GridView{

            id:recommendView
            anchors.fill: parent


            header:
                Label{
                    text: "Recommend Videos"
                    horizontalAlignment: Qt.AlignCenter
                    font.bold: true
                    bottomPadding: 15
                    font.pointSize: 18
                }

            model: mainPlaylist
            delegate: recommendDelegate

            cellHeight: 180
            cellWidth: 200
            anchors.leftMargin: 45
        }





        Component{
            id:recommendDelegate

            Item{

                Column{
                    anchors.fill: parent

                    Rectangle{
                        id:recommendImageRec
                        width: recommendView.cellWidth-20
                        height: recommendView.cellHeight-60

                        radius: 5

                        layer.enabled: true
                        layer.effect: OpacityMask{
                            maskSource: Rectangle{
                                width:recommendImageRec.width
                                height: recommendImageRec.height
                                radius: recommendImageRec.radius
                            }
                        }

                        Image {
                            anchors.fill: parent
                            asynchronous: true
                            source: "image://playlistTh/"+title
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            fillMode: Image.PreserveAspectCrop

                        }

                        HoverHandler{
                            onHoveredChanged:{
                                parent.scale = hovered ? 1.05 : 1.0
                            }
                        }

                        TapHandler{
                            onTapped: {
                                stackView.vpath = path
                                stackView.vindex = index
                                changePageForPlayer()

                            }
                        }

                        Behavior on scale {
                            NumberAnimation{
                                duration: 100
                            }
                        }
                    }



                    Label{
                        width: recommendView.cellWidth-20
                        height: 40

                        text: title

                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        font.bold: true


                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
            }
        }


    }
}
