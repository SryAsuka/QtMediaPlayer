import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia


Item{
    id : control

    required property  MediaPlayer mediaPlayer
    property int  mediaPlayerState: mediaPlayer.playbackState
    property alias muted: audio.muted
    property alias volume: audio.volume

    height: frame.height

    opacity: 1

    Frame{
        id:frame
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        background: Rectangle {
            color: "white"
        }

        ColumnLayout {
            id: playbackControlPanel
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            PlaybackSeekControl {
                Layout.fillWidth: true
                mediaPlayer: control.mediaPlayer
            }

            RowLayout{
            AudioControl {
                id: audio
                Layout.minimumWidth: 100
                Layout.maximumWidth: 150
                Layout.fillWidth: true
                mediaPlayer: control.mediaPlayer

                }

            PlaybackRateControl{
                Layout.minimumWidth: 100
                Layout.maximumWidth: 150
                Layout.fillHeight: true
                Layout.fillWidth: true
                mediaPlayer: control.mediaPlayer
            }

            }
        }
    }
}
