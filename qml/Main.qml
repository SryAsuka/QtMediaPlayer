/**
 * 主窗口
 * 实现不同界面的显示与切换
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Particles
import QtQuick.Layouts
import "components"
import "pages"

ApplicationWindow {
    id: window

    flags: Qt.Window | Qt.FramelessWindowHint

    property int mWINDOW_WIDTH: 1280
    property int mWINDOW_HEIGHT: 720

    width: mWINDOW_WIDTH
    height: mWINDOW_HEIGHT

    minimumWidth: 800
    minimumHeight: 450

    property string mFONT_FAMILY: "微软雅黑"

    visible: true
    color: "#00000000"
    title: qsTr("Media Player")

    Component {
        id: homePage
        HomePage { }
    }

    Component {
        id: playerPage
        PlayerPage { }
    }

    Component {
        id: aboutPage
        AboutPage { }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        //initialItem: myhomepage
        initialItem: homePage
    }

    function changePageForHome() { stackView.replace( homePage ) }

    function changePageForPlayer() { stackView.replace( playerPage ) }

    function changePageForAbout() { stackView.replace( stackView ) }
}
