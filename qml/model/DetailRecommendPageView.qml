/*
*  To set recentList
*  Author: SryAsuka
*  Data: 2023.6
*/


import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml
import "../components"

Item{

    ScrollView{
        id: homeScrollView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff


        //open files
        Rectangle{
            id : fileOpen
            anchors{
            top: parent.top
            bottom: recommendFiles.top
            left: parent.left
            right: parent.right
            }
        }

        //Recommend Files
        Rectangle{
            id : recommendFiles
        }

        //RecentFiles
        Rectangle{
            id : recentFiles
        }

    }

}
