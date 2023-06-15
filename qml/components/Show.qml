import QtQuick
import QtQuick.Controls

Item {
    property int index: 1
    width: 640
    height: 480
    anchors.centerIn: parent
    Image {
        id:img
        anchors.fill: parent
        source: "qrc:/assets/picture/img1.jpg"
    }

    Rectangle
    {
        id:leftbtn
        width: 50
        height: 300
        color: "black"
        opacity: 0.6
        radius: 5
        anchors.left: img.left
        anchors.leftMargin: 3
        anchors.verticalCenter: img.verticalCenter

        Text {
            anchors.centerIn: leftbtn
            text: qsTr("<")
            color: "#FFFFFF"
            font.pointSize: 18
            font.bold: true

        }

        MouseArea{
        anchors.fill: leftbtn
        cursorShape: leftbtn.enabled?Qt.PointingHandCursor:Qt.ForbiddenCursor
        onPressed: {leftbtn.color="#FFFFFF"}
        onClicked: {
            index--
            if(index<1) index=3
            img.source="qrc:/assets/picture/img"+index+".jpg"
            leftbtn.color="#000000"}
        }

    }

    Rectangle
    {
        id:rightbtn
        width: 50
        height: 300
        color: "black"
        opacity: 0.6
        radius: 5
        anchors.right: img.right
        anchors.rightMargin: 3
        anchors.verticalCenter: img.verticalCenter


        Text {
            anchors.centerIn: rightbtn
            text: qsTr(">")
            color: "#FFFFFF"
            font.pointSize: 18
            font.bold: true

        }

        MouseArea{
        anchors.fill: rightbtn
        cursorShape: rightbtn.enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
        onPressed: { rightbtn.color="#FFFFFF" }
        onClicked: {
            index++
            if(index>3) index=1
            img.source="qrc:/assets/picture/img"+index+".jpg"
            rightbtn.color="#000000"}
        }

    }
}
