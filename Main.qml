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
    property var liststr:[]
    mySql.getMsgList:liststr
//    property var liststr: ["呵呵o(*￣︶￣*)o","nihao","ceshisx","你是说","啥意思","哈哈"]
    property int index: 0

//    Rectangle{
//       anchors.fill: parent;
//       id : window
//       color: "black"
//    }
//    //动态加载


//    function addItem()
//        {
//           var oldy = Math.random()*500%200 ;
//           for (var i = 0 ; i < 1; ++i)
//           {
//               var component = Qt.createComponent("/root/untitled/barrage.qml");
//               if (component.status === Component.Ready)
//               {
//                   var textitem = component.createObject(window);
//                   oldy += Math.random()*200;
//                   textitem.y = oldy;
//                   index = Number(oldy%5);
//                   textitem.textstr = liststr[index];
//               }
//           }
//        }
//        Component.onCompleted: {
//                addItem();
//        }
//        Timer {
//                 interval: 1000; running: true; repeat: true
//                 onTriggered: addItem()
//             }

}
