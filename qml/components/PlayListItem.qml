/*  To get playlist data and Design listview style
 *  Author: SryAsuka
 *  Data: 2023.6
**/


import QtQuick
import QtQuick.Controls
import QtCore
import Qt.labs.folderlistmodel
import QtQuick.Layouts


Item{

    id : playListItem
    width: 420
    height: 90
    property string rowNum : (index + 1).toString()


    Rectangle{
        anchors.fill: parent

        color: "transparent"
        z:240

        RowLayout{
            anchors.fill: parent

            //编号
            Label{
                text: pad(playListItem.rowNum,dListView.count.toString().length)
                horizontalAlignment: Qt.AlignCenter

                function pad(number, length) {
                    while (number.length < length)
                        number = "0" + number;

                    return number;
                }
                font.bold: true
                color: "#ffffff"
                font.pointSize: 12
                Layout.leftMargin: 5

            }

            //修饰边
            Rectangle{
                width: 1
                color: "white"
                Layout.fillHeight: true
            }

            //图片时间
            Item{
                    width: (playListItem.height - 30) * 1.33333
                    height: playListItem.height - 30


                    Image{
                        anchors.fill: parent
                        source: "image://playlistTh/"+title
                        asynchronous: true
                        fillMode: Image.PreserveAspectFit
                        clip: true
                    }

                    Rectangle {
                        visible: true
                        height: -15
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right

                        color: "transparent"

                        Label{
                            text: duration
                            color: "#ffffff"

                            anchors.centerIn: parent
                            horizontalAlignment: Qt.AlignCenter
                            font.bold: true
                        }

                    }
                }

            //视频名
            Label{

                text: title
                color: "#ffffff"

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                font.bold: true

                layer.enabled: true
                Layout.fillWidth: true
                Layout.fillHeight: true

                elide: Text.ElideRight
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }



        }
        TapHandler{
            id:tapHandler

            gesturePolicy: TapHandler.ReleaseWithinBounds

            onTapped: {
                listView.currentIndex = index
            }
            onDoubleTapped: {
                videoPlayer.player.source = "file://" + path

                // 初始化弹幕
                filepath = path
                bulletxml.initDanmu(filepath.replace(new RegExp(title + '$'), ' '), title)

                videoTitleBar.dVideoTitle.text = title
                subProvider.selectedSubFile(mainPlaylist.setDefaultSub(listView.currentIndex));

            }
        }



    }

}
