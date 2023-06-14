import QtQuick
import QtQuick.Controls
import "pages"

ApplicationWindow {
    width: 1200
    height: 800
    visible: true
    title: qsTr("Media Player")

    PlayerPage {
        id: playerPage
        anchors.fill: parent
    }
}
