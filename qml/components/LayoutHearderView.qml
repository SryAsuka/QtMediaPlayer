/**
 * 顶部工具栏组件
 * 日期：2023.6.16下午
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property point point: Qt.point(x,y)
    property bool isSmallWindow: false

    anchors {
        left: parent.left
        right: parent.right
    }

    height: 70

    color: "#eeeeee"

    // 图标展示
    Image {
        id: iconImage
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 50
        }
        source: "qrc:/assets/icon/video.png"
        width: 50
        fillMode: Image.PreserveAspectFit
    }

    // 鼠标拖动，必须放在最上方
    MouseArea {
        propagateComposedEvents: true
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onPressed: setPoint(mouseX,mouseY)
        onMouseXChanged: moveX(mouseX)
        onMouseYChanged: moveY(mouseY)
    }

    // 首页按钮
    HomeToolButton {
        id: homePageButton
        anchors {
            verticalCenter: parent.verticalCenter
            left: iconImage.right
            leftMargin: 30
        }

        contentItem: Text {
            text: "Home"
            color: "#1195db"
            font.pixelSize: 18
            font.weight: Font.Bold
        }
        toolTip: "Home"
    }

    // 播放按钮
    HomeToolButton {
        id: playButton
        anchors {
            verticalCenter: parent.verticalCenter
            left: homePageButton.right
            leftMargin: 30
        }

        contentItem: Text {
            text: "Play"
            color: "#333333"
            font.pixelSize: 18
            font.weight: Font.Bold
        }
        toolTip: "Play"

        onClicked: {
            window.changePageForPlayer()
        }
    }

    // 关于
    HomeToolButton {
        anchors {
            verticalCenter: parent.verticalCenter
            right: min.left
            rightMargin: 20
        }

        icon.source: "qrc:/assets/icon/about.png"
        toolTip: "About"
        onClicked: {
            window.changePageForAbout()
        }
    }

    // 最小化按钮
    HomeToolButton {
        id: min
        anchors {
            verticalCenter: parent.verticalCenter
            right: maxWindow.left
            rightMargin: 20
        }

        icon.source: "qrc:/assets/icon/min.png"
        toolTip: "最小化"
        onClicked: {
            window.hide()
        }
    }

    // 退出全屏
    HomeToolButton {
        id:resize
        anchors {
            verticalCenter: parent.verticalCenter
            right: colseButton.left
            rightMargin: 20
        }

        icon.source: "qrc:/assets/icon/exitMax.png"
        toolTip: "退出全屏"
        visible: false
        onClicked: {
            setWindowSize()
            window.visibility = Window.AutomaticVisibility
            maxWindow.visible = true
            resize.visible = false
        }
    }

    // 全屏按钮
    HomeToolButton {
        id:maxWindow
        anchors {
            verticalCenter: parent.verticalCenter
            right: colseButton.left
            rightMargin: 20
        }

        icon.source: "qrc:/assets/icon/max.png"
        toolTip: "全屏"
        onClicked: {
            window.visibility = Window.Maximized
            maxWindow.visible = false
            resize.visible = true
        }
    }

    // 关闭按钮
    HomeToolButton {
        id: colseButton
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 30
        }

        icon.source: "qrc:/assets/icon/close.png"
        toolTip: "Exit"
        onClicked: {
            Qt.quit()
        }
    }

    // 设置窗口大小
    function setWindowSize(width = window.mWINDOW_WIDTH,
                           height = window.mWINDOW_HEIGHT) {
        window.width = width
        window.height = height
        window.x = (Screen.desktopAvailableWidth - window.width) / 2
        window.y = (Screen.desktopAvailableHeight - window.height) / 2
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

