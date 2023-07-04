/**
 *  To open the play list
 *  Author: SryAsuka
 *  Data: 2023.6
 **/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Particles
import "../components"
import "../model"

Item {
    // background
    Rectangle {
        id: background
        anchors.fill: parent
        color: Qt.rgba(globalPageColor.r + 0.1, globalPageColor.g + 0.1, globalPageColor.b + 0.1, globalPageColor.a)
        opacity: 0.95
    }

    Item {
        anchors.fill: parent

        LayoutHearderView {
            id:layoutHeaderView
            z:1000

            homePageButtonColor: globalButtonColor
            settingButtonColor: "#333333"
        }

        //recommend recently played
        DetailRecommendPageView {
            id:detailpage

            anchors.top: layoutHeaderView.bottom
            anchors.bottom: parent.bottom

        }
    }



}
