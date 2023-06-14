import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {


    required property MediaPlayer mediaPlayer
    property bool muted: false
    property real volume: volumeSlider.value/100.

    implicitHeight: buttons.height

    function editAuidoButton(){
                    if(volumeSlider.value >= 75)
                    {
                        muteButton.icon.name = "audio-volume-high"
                    }else if(75 > volumeSlider.value && volumeSlider.value >= 25){
                        muteButton.icon.name = "audio-volume-medium"
                    }else if(volumeSlider.value < 25 ){
                        muteButton.icon.name = "audio-volume-low"
                    }
                }


    RowLayout {
        anchors.fill: parent

        Item {
            id: buttons

            width: muteButton.implicitWidth
            height: muteButton.implicitHeight

            RoundButton {
                id: muteButton
                radius: 50.0
                icon.name: "audio-volume-high"
                onClicked: { muted = !muted }

            }
        }

        Slider {
            id: volumeSlider
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            enabled: true
            to: 100.0
            value: 100.0

            onValueChanged: editAuidoButton()
        }
    }
}
