import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 1.0
import "components"

ApplicationWindow {
    id:root
    width: 1600
    height:900
    visible: true
    title: qsTr("PlayVideo")

    //background
    Rectangle {
        id:background
        anchors.fill: parent
        color:"#ff363b3f"
    }

    //Menu
    Item {
        id:menu
        width: 800
        height:100
        Layout.fillWidth: true
        anchors.left: background.left
        //anchors.horizontalCenter: background.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: 100

        Row {
            spacing: 10
            MenuButton{ text:"About" }
            MenuButton{ text:"Setting" }
            MenuButton { }
        }
    }

    //Show
    Item {
        id:myShow
        width: root.width
        height:480
//      Layout.preferredWidth: 800
//      Layout.fillHeight: true
        anchors.top: menu.bottom
        anchors.verticalCenter: background.verticalCenter
        anchors.horizontalCenter: background.horizontalCenter
        anchors.topMargin: 10
        Show{ }
    }

    //content
    Item {
        id:content
        width: parent.width
        height: 600

        //anchors.fill: parent
        anchors.top: myShow.bottom
        anchors.topMargin: 10
        //anchors.horizontalCenter: background.horizontalCenter
        GridView {
            id:myGridView
            width:parent.width
            height:parent.height
            cellWidth: 100
            cellHeight: 100
            clip: true//超出边界不显示进行裁剪
            boundsBehavior: Flickable.StopAtBounds//滑动不超过父边框大小
            model: 200
            delegate: Rectangle {
                width: myGridView.cellWidth*0.8
                height: myGridView.cellHeight*0.8
                color: "lightblue"
                Text {
                    text: qsTr("test")
                }
            }
        }
    }
}

