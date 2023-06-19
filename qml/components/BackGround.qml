import QtQuick 2.15
import QtQuick.Particles 2.0
//星空闪烁的背景
Rectangle {
    property int index: 1
        id:myBackground
        anchors.fill: parent
        color:"#000000"
        ParticleSystem {
            anchors.fill: parent

            ImageParticle {
                groups: ["stars"]
                anchors.fill: parent
                source: "qrc:/assets/background/spot.png"
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
    }
