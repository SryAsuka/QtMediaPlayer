import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "../components"

Item {
    // background
    Rectangle {
        id: background
        anchors.fill: parent
        color: Qt.rgba(globalPageColor.r + 0.1, globalPageColor.g + 0.1, globalPageColor.b + 0.1, globalPageColor.a)
        opacity: 0.95
    }

    Item {
        anchors.fill: parent

        LayoutHearderView {
            id:layoutHeaderView
            z:1000

            homePageButtonColor: "#333333"
            settingButtonColor: globalButtonColor
        }

        ColorDialog {
            id: colorDialogButton
            onAccepted: {
                settings.gb = selectedColor
            }
        }

        ColorDialog {
            id: colorDialogGlobal
            onAccepted: {
                settings.gp = selectedColor
            }
        }



        Button {
            id: pageColorButton
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            text: "Change Page Color"
            onClicked: {
                colorDialogGlobal.open()
            }
        }

        Button {
            id: buttonColorButton
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: pageColorButton.bottom
                topMargin: 20
            }

            text: "Change Button Color"
            onClicked: {
                colorDialogButton.open()
            }

        }

        Button {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: buttonColorButton.bottom
                topMargin: 20
            }

            text: "Reset Color"
            onClicked: {
                settings.gb = "#1195db"
                settings.gp = "#eeeeee"
            }

        }

    }

}
