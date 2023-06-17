import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 1.0
import QtQuick.Particles 2.0
import "../components"
Item {
    Rectangle {
        id:background
        anchors.fill: parent
        color:"#000000"
    }
    ParticleSystem {
            anchors.fill: parent

            ImageParticle {
                groups: ["stars"]
                anchors.fill: parent
                source: "qrc:/assets/icon/start.png"
            }

            Emitter {
                group: "stars"
                emitRate: 80
                lifeSpan: 2400
                size: 24
                sizeVariation: 8
                anchors.fill: parent

            }

            Turbulence {
                anchors.fill: parent
                strength: 2
            }
        }

    //Menu
    Item {
        id:myMenu
        width: 800
        height:100
        Layout.fillWidth: true
        anchors.left: background.left
        //anchors.horizontalCenter: background.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: 100

        Row {
            spacing: 10
            MenuButton {
                text:"MainPage"
            }
            MenuButton{ text:"Setting" }
            MenuButton {text:"About" }
        }
    }

}
