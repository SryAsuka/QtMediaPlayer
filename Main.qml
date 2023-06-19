import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Controls
import QtQuick.Layouts 1.0

ApplicationWindow {
    id:rootWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    function refreshDataModel(){
        dataModel.clear()
        mysql.selectAllData()
    }

    //接收 C++ 端发送过来的信号
    Connections{
        target: mysql
        onSendQueryInfo:{
            dataModel.append({id:mID,name:mName})
        }
        onUpdateView:{
            refreshDataModel()
        }
    }

    Rectangle{
        id:btnRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 200
        color: "#8496A2"
        Column{
            anchors.fill: parent
            spacing: 5
            padding: 2
            Row{
                height: 30
                spacing: 2
                Button{
                    width: 50
                    height: 30
                    text:"查询"
                    onClicked: {
                        refreshDataModel()
                    }
                }
                Button{
                    width: 70
                    height: 30
                    text:"插入新数据"
                    onClicked: {
                        mysql.insertData()
                    }
                }
                Button{
                    width: 70
                    height: 30
                    text:"删除数据"
                    onClicked: {
                        mysql.deleteData()
                    }
                }
            }
            Row{
                height: 30
                spacing: 5
                Button{
                    width: 70
                    height: 30
                    text:"更改数据"
                    onClicked: {
                        mysql.updateData()
                    }
                }
            }

        }

    }


    Rectangle{
        anchors.top: parent.top
        anchors.left: btnRect.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#627480"
        ListView{
            id:dataView
            anchors.fill: parent
            spacing:5
            clip: true
            header:Rectangle{
                width: parent.width - 10
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: Qt.rgba(1.0,1.0,1.0,0.0)

                Text{
                    id:idHeader
                    width: 25
                    height: 25
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    text:"ID"
                }
                Text{
                    width: 25
                    height: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:"Name"
                }

            }

            model: ListModel{
                id:dataModel
            }
            delegate: Rectangle{
                id:dataDelegate
                width: parent.width - 10
                anchors.horizontalCenter: parent.horizontalCenter
                height: 20
                color: Qt.rgba(1.0,1.0,1.0,0.0)
                border.color: "white"
                border.width: 1
                radius: 10
                Text{
                    id:friendsID
                    text: id
                    anchors.left: parent.left
                    anchors.leftMargin: 11
                }
                Text{
                    id:friendsName
                    text:name
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }
        }

    }
}
