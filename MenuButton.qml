import QtQuick

Item {
    property  alias text: txt.text
    width: 150
    height:40
    Rectangle{
    id:background
    anchors.fill: parent
    color:"#ff6b696a"
    border.color: "black"
    radius: 5
    opacity: 0
    }
    Text{
    id:txt
    anchors.centerIn: background
    text:"My Vedio"
    font. family: "微软雅黑"
    font.pointSize: 20
    color:"#ffffff"
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: background.enabled?Qt.PointingHandCursor:Qt.ForbiddenCursor
        hoverEnabled: true
        onEntered: {
        background.opacity=1
        }
        onExited: {
        background.opacity=0
        }

    }


}
