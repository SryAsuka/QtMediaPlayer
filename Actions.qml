/*  There are all actions's UIs in the QtMediaPlayer app.
 *  Author: QtMediaPlayer Group
 *  Data: 2023.6.9
**/
import QtQuick
import QtQuick.Controls

Item{

    property alias openAction: open
    property alias folderAction: folder
    property alias closeAction: close
    property alias exitAction: exit
    property alias startAction: start
    property alias pauseAction: pause
    property alias stopAction: stop
    property alias aboutAction: about
    property alias playListAction: playList

    Action {
        id: open
        text: qsTr("&OpenFile...")
        icon.name: "document-open"
        shortcut: "StandardKey.Open"
    }

    Action{
        id:folder
        text: qsTr("OpenFold&er...")
        icon.name: "document-open-recent"
        shortcut: "Ctrl + d"
    }
    Action {
        id: close
        text: qsTr("&Close")
        icon.name: "document-close"
//        shortcut: "Ctrl + d"
    }

    Action {
        id: exit
        text: qsTr("E&xit")
        icon.name: "application-exit"
    }

    Action{
        id:start
        text: qsTr("&Start")
        icon.name: "media-playback-start"
        enabled: false

    }

    Action{
        id:pause
        text: qsTr("&Pause")
        icon.name: "media-playback-pause"
    }

    Action{
        id:stop
        text: qsTr("&Stop")
        icon.name: "media-playback-stop"

    }

    Action {
        id: about
        text: qsTr("&About")
        icon.name: "help-about"
    }

    Action {
        id: playList
        text: qsTr("&Play List")
        icon.name: "help-about"
    }
}
