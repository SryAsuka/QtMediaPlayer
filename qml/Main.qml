/**
 * 主窗口
 * 实现不同界面的显示与切换
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Particles
import QtQuick.Layouts
import Qt.labs.settings
import "components"
import "./pages"

ApplicationWindow {
    id: window

    flags: Qt.Window | Qt.FramelessWindowHint

    property int mWINDOW_WIDTH: 1280
    property int mWINDOW_HEIGHT: 720

    width: mWINDOW_WIDTH
    height: mWINDOW_HEIGHT

    minimumWidth: 800
    minimumHeight: 450

    // 全局字体设置
    property string mFONT_FAMILY: "微软雅黑"
    // 全局按钮设置
    property color globalButtonColor: "#1195db"
    // 全局背景颜色设置
    property color globalPageColor: "#eeeeee"

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

    Component {
        id: settingPage
        SettingPage { }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: homePage
    }

//    Settings {
//        id: settings
//        fileName: "conf/settings.ini"
//    }


    function changePageForHome() { stackView.replace( homePage ) }

    function changePageForPlayer() { stackView.replace( playerPage ) }

    function changePageForAbout() { stackView.replace( aboutPage ) }

    function changePageForSetting() { stackView.replace( settingPage ) }
}
