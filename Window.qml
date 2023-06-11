/* QtMediaPlayer is a free video viewer.
 * Distributed under GPL, Version 3.0.
 * The file defines the appwindow of QtMediaPlayer, and setts up all UIs' logic, except the content's.
 *  Author: QtMediaPlayer Group
 *  Data: 2023.6.9
**/
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

ApplicationWindow{
    id:appWindow
    visible: true
    width: 640
    height: 480

    menuBar: MenuBar{
        id:appMenuBar

        Menu{
            title: qsTr("&File")
            //RECOMMENDED Way: to encapsulate actions using MenuItem
            MenuItem{action: actions.openAction}
            MenuItem{action: actions.closeAction}
            MenuItem{action: actions.exitAction}
        }

        Menu{
            title: qsTr("&Play")
            //using Action object as menu item directly
            MenuItem{action: actions.startAction}
            MenuItem{action: actions.pauseAction}
            MenuItem{action: actions.stopAction}
        }

        Menu {
            title: qsTr("&Help")
            //using Action object id as menu item
            contentData:[ ]
        }
    }

    header: ToolBar {
        id:appToolBar
        RowLayout{
            ToolButton{ action: actions.openAction }
            ToolButton{ action: actions.closeAction }
            ToolSeparator{}
            ToolButton{ action: actions.startAction }
            ToolButton{ action: actions.pauseAction }
            ToolButton{ action: actions.stopAction }
        }
    }

    //setting the logic of all actions
    Actions{
        id:actions

        openAction.onTriggered: content.dialog.openFileDialog()
        closeAction.onTriggered: Qt.quit()

        startAction.onTriggered: {
            if(!content.mediaPlayer.playing){
                content.mediaPlayer.play()
                pauseAction.enabled = true
                startAction.enabled = false
            }
        }
        pauseAction.onTriggered: {
            if(content.mediaPlayer.playing){
                content.mediaPlayer.pause()
                startAction.enabled = true
                pauseAction.enabled = false
            }
        }
        stopAction.onTriggered: {
            startAction.enabled = true
            pauseAction.enabled = false
            content.mediaPlayer.stop()
        }

    }

    Content{
        id:content
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: playbackControl.top


    }

    //the play control
    PlaybackControl{
        id: playbackControl

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        mediaPlayer: content.mediaPlayer
    }
}
