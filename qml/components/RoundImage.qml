import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    property string imgSour: ""
    property alias text: txt.text
    property alias img: img.source
    width: 300
    height: 150
    Rectangle {
        id:rec
        color: "red"
        radius: 5
        anchors.fill: parent

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            id: img
            source: ""

        }

        Text {
            id: txt
            color: "#FFFFFF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            text: qsTr("For test")
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: rec.enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
        }
    }


    }

