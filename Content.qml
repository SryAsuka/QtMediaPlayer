import QtQuick

Item {
    GridView{
    id:myGridView
    width:parent.width
    height:parent.height
    cellWidth: 100
    cellHeight: 100
    clip: true//超出边界不显示进行裁剪
    boundsBehavior: Flickable.StopAtBounds//滑动不超过父边框大小
    model: 200
    delegate: Rectangle{
    width: myGridView.cellWidth*0.8
    height: myGridView.cellHeight*0.8
    color: "lightblue"
    Text {
        text: qsTr("test")
    }
    }
}
}
