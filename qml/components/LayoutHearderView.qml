/**
 * 顶部工具栏组件
 * 日期：2023.6.16下午
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    id: hearderView
    property point point: Qt.point(x,y)
    property bool isSmallWindow: false
    property color homePageButtonColor: globalButtonColor
    property color settingButtonColor: "#333333"

    anchors {
        left: parent.left
        right: parent.right
    }

    height: 70

    color: globalPageColor

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

    // 鼠标拖动
    Item {
        anchors {
            fill: parent
            rightMargin: 10
        }
        PointHandler {
            acceptedDevices: PointerDevice.Mouse
            acceptedButtons: Qt.LeftButton
            target: hearderView
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
            color: homePageButtonColor
            font.pixelSize: 18
            font.weight: Font.Bold
        }
        toolTip: "Home"

        onClicked: {
            window.changePageForHome()
        }
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

    // 导入文件按钮
    HomeToolButton {
        anchors {
            verticalCenter: parent.verticalCenter
            right: setting.left
            rightMargin: 30
        }

        icon.source: "qrc:/assets/icon/import.png"
        toolTip: "Import"
        onClicked: {
            // 实现导入文件夹
        }
    }

    // 设置按钮
    HomeToolButton {
        id: setting
        anchors {
            verticalCenter: parent.verticalCenter
            right: about.left
            rightMargin: 30
        }

        icon.source: "qrc:/assets/icon/systemSetting.png"
        icon.color: settingButtonColor
        toolTip: "Setting"
        onClicked: {
            // 切换设置窗口
            window.changePageForSetting()
        }
    }

    // 关于
    HomeToolButton {
        id: about
        anchors {
            verticalCenter: parent.verticalCenter
            right: min.left
            rightMargin: 40
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
        id: resize
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
        id: maxWindow
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
        if(x < -(window.width-70)) x = - (window.width-70)
        if(x > Screen.desktopAvailableWidth-70) x = Screen.desktopAvailableWidth-70
        window.x = x
    }

    function moveY( mouseY = 0 ) {
        var y = window.y + mouseY-point.y
        if(y <= 0) y = 0
        if(y > Screen.desktopAvailableHeight-70) y = Screen.desktopAvailableHeight-70
        window.y = y
    }

    function setPoint(mouseX =0, mouseY = 0) {
        point = Qt.point(mouseX, mouseY)
    }
}

