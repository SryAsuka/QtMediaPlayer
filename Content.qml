/*  The content component of the QtMediaPlayer appwindow.
 *  Author: QtMediaPlayer Group
 *  Data: 2023.6.9
**/
import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Dialogs
import QtMultimedia
import QtQuick.Controls  as QQC

Item{
    //set visible(if not set ,it will not show video)
    visible: true
    //to control the full screen
    property bool isFullScreen: false
    property alias dialog: allDialog
    property alias mediaPlayer: mediaplayer

    signal fullScreen()
    signal window()


    function setVideoPath(filePath){
        mediaplayer.source = filePath;
        console.log(filePath);
        mediaplayer.play()
    }

    //set mediaPlayer to load audio and video
    MediaPlayer{
        id: mediaplayer

        audioOutput: AudioOutput {
            id :audio
            muted: playbackControl.muted
            volume: playbackControl.volume
        }
        videoOutput: videoOutput

    }

    //set videooutput
    VideoOutput {
            id: videoOutput
            anchors.fill: parent
         }

    //set full screen or not
    TapHandler {
             onDoubleTapped: {
                 isFullScreen ? showNormal() : showFullScreen()
                 isFullScreen = !isFullScreen
            }
         }

    Dialogs{
        id:allDialog
        //get file path
        fileOpenDialog.onAccepted:
            setVideoPath(fileOpenDialog.selectedFile)

    }
}
