/**
 * 首页
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Particles
import "../components"
import "../model"

Item{
    // background
    Rectangle {
        id: background
        anchors.fill: parent
        color:"#ffffff"
        opacity: 0.95

    }

    Item {
        anchors.fill: parent

        LayoutHearderView {
            id:layoutHeaderView
            z:1000
        }

        DetailRecommendPageView {
            //anchors.fill: parent
        }
    }

//    // 粒子主题！
//    ParticleSystem {
//        anchors.fill: parent

//        ImageParticle {
//            groups: ["stars"]
//            anchors.fill: parent
//            source: "qrc:/assets/icon/start.png"
//        }

//        Emitter {
//            group: "stars"
//            emitRate: 80
//            lifeSpan: 2400
//            size: 24
//            sizeVariation: 8
//            anchors.fill: parent
//        }

//        Turbulence {
//            anchors.fill: parent
//            strength: 2
//        }
//    }

    //Menu
//    Item {
//        id:myMenu
//        width: 800
//        height:100
//        Layout.fillWidth: true
//        anchors.left: background.left
//        //anchors.horizontalCenter: background.horizontalCenter
//        anchors.top: background.top
//        anchors.topMargin: 100

//        Row {
//            spacing: 10
//            MenuButton {
//                text:"MainPage"
//            }
//            MenuButton{ text:"Setting" }
//            MenuButton {text:"About" }
//        }
//    }

//    //Show
//    Item {
//        id:myShow
//        width: window.width
//        height:480
////      Layout.preferredWidth: 800
////      Layout.fillHeight: true
//        anchors.top: myMenu.bottom
//        anchors.verticalCenter: background.verticalCenter
//        anchors.horizontalCenter: background.horizontalCenter
//        anchors.topMargin: 10
//        VideoBannerView{ }
//    }

//    //content
//    Item {
//        id:myContent
//        width: parent.width
//        height: 600

//        //anchors.fill: parent
//        anchors.top: myShow.bottom
//        anchors.topMargin: 10
//        //anchors.horizontalCenter: background.horizontalCenter
//        GridView {
//            id:myGridView
//            width:parent.width
//            height:parent.height
//            cellWidth: 100
//            cellHeight: 100
//            clip: true//超出边界不显示进行裁剪
//            boundsBehavior: Flickable.StopAtBounds//滑动不超过父边框大小
//            model: 200
//            delegate: Rectangle {
//                width: myGridView.cellWidth*0.8
//                height: myGridView.cellHeight*0.8
//                color: "lightblue"
//                Text {
//                    text: qsTr("test")
//                }
//            }
//        }
//    }



}
