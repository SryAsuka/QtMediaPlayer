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
                globalButtonColor = selectedColor
            }
        }

        ColorDialog {
            id: colorDialogGlobal
            onAccepted: {
                globalPageColor = selectedColor
            }
        }

        Button {
            id: buttonColorButton
            text: "Change Button Color"
            anchors.centerIn: parent
            onClicked: {
                colorDialogButton.open()
            }
        }

        Button {
            text: "Change Global Color"
            anchors.top: buttonColorButton.bottom
            onClicked: {
                colorDialogGlobal.open()
            }
        }

    }

}
