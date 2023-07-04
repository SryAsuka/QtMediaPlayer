import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Particles
import "../components"

Rectangle {
    color: "black"
    property point point: Qt.point(x,y)

    // 背景
    Item {
        id: mybackground
        anchors.fill: parent
        BackGround{}
    }

    // 鼠标拖动
    Item {
        anchors {
            fill: parent
            rightMargin: 10
        }
        PointHandler {
            acceptedDevices: PointerDevice.Mouse
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.CrossCursor

            onActiveChanged: setPoint(point.position.x, point.position.y)

            onPointChanged: {
                if (active) {
                    moveX(point.position.x)
                    moveY(point.position.y)
                }
            }
        }
    }

    // 鼠标缩放区域
    Rectangle {
        id: topRightCorner
        width: 10
        height: 10
        anchors.top: parent.top
        anchors.right: parent.right
        color: "transparent"

        PointHandler {
            property real startX: 0
            property real startY: 0

            acceptedDevices: PointerDevice.Mouse
            acceptedButtons: Qt.LeftButton

            onActiveChanged: {
                if (active) {
                    startX = point.position.x
                    startY = point.position.y
                }
            }

            onPointChanged: {
                if (active) {
                    window.width += point.position.x - startX;
                    window.height -= point.position.y - startY;
                    window.y += point.position.y - startY;
                }
            }
        }

        HoverHandler { cursorShape: Qt.SizeBDiagCursor }
    }


    // 返回按钮
    Button {
        id: returnButton
        anchors {
            top: parent.top
            topMargin: 30
            left: parent.left
            leftMargin: 30
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
        ToolTip.visible: hovered
        ToolTip.text: "返回"

        onClicked: {
            window.changePageForHome()
        }
    }

    // 标题栏
//    Item{
//        width: 800
//        height:100
//        Layout.fillWidth: true
//        anchors.left: mybackground.left
//        anchors.horizontalCenter: mybackground.horizontalCenter
//        anchors.top: mybackground.top
//        anchors.topMargin: 100
//        MyMenuBar{}}

    // 文本框
    Item {
        id: myText
        //width: myMenuBar.width-100
        height: 500
        anchors.fill: parent
        //anchors.top: myMenuBar.bottom
        TextArea {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: '该播放器由李欣航、范榆康、郑雅文共同制作。\r\n立志于为大众提供方便好用、易于交互的视屏播放软件'
            font.pointSize: 35
            color: "#FFFFFF"
        }
    }

    // 移动窗口
    function moveX( mouseX = 0 ) {
        var x = window.x + mouseX-point.x
        if(x<-(window.width-70)) x = - (window.width-70)
        if(x>Screen.desktopAvailableWidth-70) x = Screen.desktopAvailableWidth-70
        window.x = x
    }

    function moveY( mouseY = 0 ) {
        var y = window.y + mouseY-point.y
        if(y<=0) y = 0
        if(y>Screen.desktopAvailableHeight-70) y = Screen.desktopAvailableHeight-70
        window.y = y
    }

    function setPoint(mouseX =0 ,mouseY = 0) {
        point = Qt.point(mouseX,mouseY)
//        console.log(mouseX,mouseY)
    }
}
