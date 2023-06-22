/**
 * 视频轮播图组件
 */

import QtQuick
import QtQuick.Controls

Frame {
    property int current: 0
    property alias bannerList : videoBannerView.model


    background: Rectangle {
        color: "#00000000"
    }
    PathView {
        id:videoBannerView
        width: parent.width
        height: parent.height

        clip: true

//        MouseArea {
//            anchors.fill: parent
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onEntered: {
//                bannerTimer.stop()
//            }
//            onExited: {
//                bannerTimer.start()
//            }
//        }

        delegate: Item {
            id: delegateItem
            width: videoBannerView.width * 0.7
            height: videoBannerView.height
            z: PathView.z ? PathView.z : 0
            scale: PathView.scale ? PathView.scale : 1.0

            VideoDisplayComponent {
                id: image
                //imgSrc: modelData.imageUrl
                width: delegateItem.width
                height: delegateItem.height
            }

//            MouseArea {
//                anchors.fill: parent
//                cursorShape: Qt.PointingHandCursor
//                onClicked: {
//                    if(videoBannerView.currentIndex === index){

//                    }else{
//                        videoBannerView.currentIndex = index
//                    }
//                }
//            }
        }

        pathItemCount: 3
        path: bannerPath
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Path{
        id:bannerPath
        startX: 0
        startY:videoBannerView.height / 2 - 10

        PathAttribute{name: "z"; value: 0}
        PathAttribute{name: "scale"; value: 0.6}

        PathLine{
            x:videoBannerView.width/2
            y:videoBannerView.height/2-10
        }

        PathAttribute { name: "z"; value: 2}
        PathAttribute { name: "scale"; value: 0.85}

        PathLine {
            x:videoBannerView.width
            y:videoBannerView.height/2-10
        }

        PathAttribute { name:"z"; value: 0}
        PathAttribute { name:"scale"; value: 0.6}
    }

    PageIndicator {
        id: indicator
        anchors {
            top: videoBannerView.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: -10
        }
        count: videoBannerView.count
        currentIndex: videoBannerView.currentIndex
        spacing: 10
        delegate: Rectangle {
            width: 20
            height: 5
            radius: 5
            //color: index === videoBannerView.currentIndex?"balck":"gray"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
//            MouseArea {
//                anchors.fill: parent
//                hoverEnabled: true
//                cursorShape: Qt.PointingHandCursor
//                onEntered: {
//                    bannerTimer.stop()
//                    videoBannerView.currentIndex = index
//                }
//                onExited: {
//                    bannerTimer.start()
//                }
//            }
        }
    }

    Timer {
        id:bannerTimer
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            if(videoBannerView.count>0)
                videoBannerView.currentIndex = ( videoBannerView.currentIndex + 1
                                              % videoBannerView.count)
        }
    }
}


//Item {
//    property int index: 1
//    width: 640
//    height: 480
//    anchors.centerIn: parent

//    VideoDisplayComponent {
//        id: leftVideoImage
//        width: 320
//        height: 180
//        anchors {
//            left: parent.left
//            bottom: parent.bottom
//            bottomMargin: 20
//        }

//        imgSour: getCenterVideoImageSrc()
//    }

//    VideoDisplayComponent {
//        id: centerVideoImage
//        anchors.centerIn: parent
//        width: 320
//        height: 180
//        z: 2
//        imgSour: getCenterVideoImageSrc()
//    }

//    VideoDisplayComponent {
//        id: rightVideoImage
//        width: 320
//        height: 180
//        anchors {
//            right: parent.right
//            bottom: parent.bottom
//            bottomMargin: 20
//        }
//        imgSour: getCenterVideoImageSrc()
//    }



//    Image {
//        id:img
//        anchors.fill: parent
//        source: "qrc:/assets/picture/img1.jpg"
//    }

//    function getCenterVideoImageSrc () {

//    }

//    Rectangle
//    {
//        id:leftbtn
//        width: 50
//        height: 300
//        color: "black"
//        opacity: 0.6
//        radius: 5
//        anchors.left: img.left
//        anchors.leftMargin: 3
//        anchors.verticalCenter: img.verticalCenter

//        Text {
//            anchors.centerIn: leftbtn
//            text: qsTr("<")
//            color: "#FFFFFF"
//            font.pointSize: 18
//            font.bold: true

//        }

//        MouseArea{
//        anchors.fill: leftbtn
//        cursorShape: leftbtn.enabled?Qt.PointingHandCursor:Qt.ForbiddenCursor
//        onPressed: {leftbtn.color="#FFFFFF"}
//        onClicked: {
//            index--
//            if(index<1) index=3
//            img.source="qrc:/assets/picture/img"+index+".jpg"
//            leftbtn.color="#000000"}
//        }

//    }

//    Rectangle
//    {
//        id:rightbtn
//        width: 50
//        height: 300
//        color: "black"
//        opacity: 0.6
//        radius: 5
//        anchors.right: img.right
//        anchors.rightMargin: 3
//        anchors.verticalCenter: img.verticalCenter


//        Text {
//            anchors.centerIn: rightbtn
//            text: qsTr(">")
//            color: "#FFFFFF"
//            font.pointSize: 18
//            font.bold: true

//        }

//        MouseArea{
//        anchors.fill: rightbtn
//        cursorShape: rightbtn.enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
//        onPressed: { rightbtn.color="#FFFFFF" }
//        onClicked: {
//            index++
//            if(index>3) index=1
//            img.source="qrc:/assets/picture/img"+index+".jpg"
//            rightbtn.color="#000000"}
//        }

//    }
//}

