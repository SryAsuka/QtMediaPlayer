import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls

Rectangle {

    width: 0
    height: 0
    color : "#ffffff"

    anchors.right: bulletSettingButton.right
    anchors.rightMargin: -60
    y:-160
    radius: 5
    clip: true

    property alias textColor: colorDialog.selectedColor
    property alias textSize: fontSizeBox.currentText


//    // 返回按钮
//    Button {
//        id: returnButton
//        anchors {
//            verticalCenter: parent.verticalCenter
//            right: parent.right
//        }

//        opacity: 0.8    // 设置透明度
//        // 设置背景为透明
//        background: Rectangle {
//            color: "transparent"
//        }

//        // 图标设置
//        icon.source: "qrc:/assets/icon/return.png"
//        icon.height: 30
//        icon.width: 30

//        onClicked: {
//            videoPlayer.bullectSettingDrawer.close()
//        }
//    }

    Column {
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: "Change font size"
            color: "black"
        }

        ComboBox {
            id: fontSizeBox
            model: ["10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30"]
            currentIndex: 0

            width: 100
        }

        Label {
            text: "Change font color"
            color: "black"
        }

        Button {
            text: "Change color"
            onClicked: colorDialog.open()

            width: 100
        }
    }

    ColorDialog {
        id: colorDialog
    }

    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                hideTimer.stop()
                hideBullectSettingTimer.stop()
            }
            else {
                hideTimer.start()
                hideBullectSettingTimer.start()
            }
        }
    }
}
