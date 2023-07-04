/**
 * 作者：范榆康
 * 日期：2023.6.16
 * 播放列表弹窗
 *
 *  To open the play list
 *  Author: SryAsuka
 *  Data: 2023.6
**/


import QtQuick
import QtQuick.Controls 2.15
import QtCore
import QtQuick.Layouts



Drawer {
    id: drawer


    property Timer controlTime
    property alias playListView: listView

    width: 420
    height: parent.height - 150
    topMargin: 60
    bottomMargin: 90
    edge: Qt.RightEdge



    background: Rectangle {
        color: "#000000"
        opacity: 0.3
        radius: 5
    }

    property alias dListView: listView
    property string filepath: ""


    // 文件列表
    ScrollView{

        id: playlistScrollView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        ListView {

            clip: true

            id: listView
            anchors.fill: parent

            currentIndex : 0
            model: mainPlaylist
            delegate: playlistdelegate
            highlight:
                Rectangle {
                    color: globalButtonColor
                    radius: 5
                    opacity: 1
                }
            highlightMoveDuration: 100
            highlightMoveVelocity: -1

        }

        Component{
            id:playlistdelegate

            PlayListItem{
                id: playListItem


                MouseArea{
                    id:mouseArea
                    anchors.fill: parent

                    onClicked: {
                        listView.currentIndex = index
                    }
                    onDoubleClicked: {                       
                        videoPlayer.player.source = "file://" + path

                        // 初始化弹幕
                        filepath = path
                        bulletxml.initDanmu(filepath.replace(new RegExp(title + '$'), ' '), title)

                        videoPlayer.player.play()
                        bShowPlayIcon()
                        videoTitleBar.dVideoTitle.text = title

                        subProvider.selectedSubFile(mainPlaylist.setDefaultSub(listView.currentIndex));
                    }
                }
            }

            }
        }

    MouseArea{
        id : drawerArea
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        onExited: {
            closerTimer.restart()
            controlTime.restart()
        }
        onEntered: {
            closerTimer.stop()
            controlTime.stop()
        }
    }

    Timer{
        id: closerTimer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            drawer.close()
        }
    }

}


