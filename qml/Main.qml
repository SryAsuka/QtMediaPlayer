import QtQuick
import QtQuick.Controls
import "pages"

ApplicationWindow {
    width: 1600
    height: 900
    visible: true
    title: qsTr("Media Player")

    PlayerPage {
        id: playerPage
        anchors.fill: parent
    }
}
