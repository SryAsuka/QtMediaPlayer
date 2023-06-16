/**
 * 视频封面展示组件
 * 获取视频的第一帧为封面，点击播放对应的视频
 * 日期：2023.6.16
 */

//import QtQuick
//import QtQuick.Controls
//import QtMultimedia
//import "../pages"

//Item {
//    // 定义组件的长宽，默认为16:9
//    //property int width: 160
//    //property int height: 90

//    id: videoDisplayComponent

//    //property alias source: value

//    Image {
//        id: cover
//        width: 160
//        height: 90

//        source: PlayerPage.video.sn
//    }

//}


import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    property string imgSrc: "qrc:/images/player"
    property int borderRadius: 5

    Image{
        id:image
        anchors.centerIn: parent
        source:imgSrc
        smooth: true
        visible: false
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
    }

    Rectangle{
        id:mask
        color: "black"
        anchors.fill: parent
        radius: borderRadius
        visible: false
        smooth: true
        antialiasing: true
    }


}


