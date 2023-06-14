import QtQuick 2.0
import QtQml 2.1
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id: main
    width: 700
    height: 100
    color: backgroundColor

    Item{
        y:0
        width: parent.width
        height: parent.height/2
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                icon.source: "qrc:/Img/speeddown.png"
                ToolTip.visible: hovered
                ToolTip.text: qsTr("后退30秒")
                onClicked: {
                    console.log("999")
                }
            }
        }
    }


//    Item{
//        y:0
//        width: parent.width
//        height: parent.height/2
//        Row {
//            anchors.horizontalCenter: parent.horizontalCenter
//            Button{
//                icon.source: "qrc:/assets/icon/close.png"
//                ToolTip.visible: hovered
//                ToolTip.text: qsTr("后退30秒")
//                onClicked: {
//                    console.log("8888")
//                }
//            }

//        }
//     }
}
