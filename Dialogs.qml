/* Here are all dialogs's UIs in QtMediaPlayer.
 *  Author: QtMediaPlayer Group
 *  Data: 2023.6.9
**/
import QtQuick
import QtCore
import Qt.labs.folderlistmodel
import QtQuick.Controls
import QtQuick.Dialogs


import QtMediaPlayer 1.0

Item{
    property alias fileOpenDialog: fileOpen
    property alias folderOpenDialog: folderOpen

    function openFileDialog() { fileOpen.open(); }
    function openFolderDialog() {folderOpen.open();}
    function openAboutDialog() { aboutDialog.open(); }
    function openPlayListDialog(){ playlist.open(); }

    function setFilesModel(file){
//        modeltest.clear();
        playlistmode.openFile(file)
//        console.log(file)
        recentFilesModel.updateRecent(file);
        viewtest.currentIndex = 0;
    }

//    function setFolderMode(folder){
//        modeltest.clear();
//        console.log(folder)
//        folderModel.folder = arguments[0];
//        viewtest.model = folderModel
//        viewtest.currentIndex = 0;

//    }

//    function basename(str)
//    {
//        return (str.slice(str.lastIndexOf("/")+1))
//    }

//    function fileDir(str){
//        let start = str;
//        let end = str.lastIndexOf("/");
//        return str.slice(start, end)
//    }

    //openFileDialog:to get video path
    FileDialog {
        id: fileOpen
        title: "Select a video file"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFile
        nameFilters: [ "Video files (*.mp4 *.avi *.mkv)" ]
    }

    FolderDialog{
        id: folderOpen
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        title: "Select a Music folder"
    }

    Dialog {
        id: aboutDialog

        title: "recent"

        Rectangle {
            width: 360; height: 200
            opacity: 1

            ListView {
                id : viewtest
                width: 360; height: 200
                model: recentFilesModel
                delegate: contactDelegate
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

//                ListModel {
//                    id: modeltest
//                }

//                FolderListModel{
//                    id: folderModel
//                    nameFilters: ["*.mp4","*.avi"]
//                }

                RecentFilesModel{
                    id:recentFilesModel
                }


            }

            Component {
                id: contactDelegate
                Item {
                    width: 360; height: 40
                    Row {
                        Text{
                            text: path+" "
                        }

                        Text{
                            text: title
                        }
                    }
                    MouseArea{
                        id:mouseArea
                        anchors.fill: parent

                        onClicked: {
                            viewtest.currentIndex = index
//                            console.log("text",viewtest.currentIndex,filePath)

//                                content.setVideoPath("file://"+filePath)

                        }
                    }
                }
            }
        }
    }

    Dialog{
        id: playlist

        Rectangle{
            width: 360; height: 200
            opacity: 1
            ListView {
                id : playListView
                width: 340; height: 180
                model: playlistmode
                delegate: playlistdelegate
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }



                PlayListmodel{
                    id:playlistmode

                    isSibling: true


                }
            }

            Component{
                id:playlistdelegate
                Item{
                    width: 360; height: 40

                    Row {
                        Text{
                            text: folderPath+"    "
                        }
                        Text{
                            text :path+"    "
                        }

                        Text{
                            text: title+"     "
                        }

                        Text{
                            text:duration
                        }
                    }

                    MouseArea{
                        id:mouseArea
                        anchors.fill: parent

                        onClicked: {
                            playListView.currentIndex = index

                                content.setVideoPath("file://"+path)

                        }
                    }

                }

            }


        }



    }
}
