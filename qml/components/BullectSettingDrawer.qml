import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls

Drawer {
    id: bullectDrawer

    property alias textColor: colorDialog.selectedColor
    property alias textSize: fontSizeBox.currentText

    width: window.width * 0.35
    height: 130

    edge: Qt.LeftEdge

    topMargin: window.height - 230


    background: Rectangle {
        color: "#000000"
        opacity: 0.9
    }

    // 返回按钮
    Button {
        id: returnButton
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }

        opacity: 0.8    // 设置透明度
        // 设置背景为透明
        background: Rectangle {
            color: "transparent"
        }

        // 图标设置
        icon.source: "qrc:/assets/icon/return.png"
        icon.height: 30
        icon.width: 30

        onClicked: {
            videoPlayer.bullectSettingDrawer.close()
        }
    }

    Column {
        anchors {
            right: returnButton.left
            verticalCenter: returnButton.verticalCenter
        }

        Label {
            text: "Change font size"
            color: "white"
        }

        ComboBox {
            id: fontSizeBox
            model: ["10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30"]
            currentIndex: 0

            width: 100
        }

        Label {
            text: "Change font color"
            color: "white"
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
}
