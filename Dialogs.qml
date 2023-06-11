/* Here are all dialogs's UIs in QtMediaPlayer.
 *  Author: QtMediaPlayer Group
 *  Data: 2023.6.9
**/
import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

Item{
    property alias fileOpenDialog: fileOpen

    function openFileDialog() { fileOpen.open(); }

    //openFileDialog:to get video path
    FileDialog {
        id: fileOpen
        title: "Select a video file"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFile
        nameFilters: [ "Video files (*.mp4 *.avi *.mkv)" ]
    }
}
