import QtQuick 2.9
import QtQuick.Controls 2.2
import "../components"

Rectangle{
    id : root
    height: 30;
    property real endx: parent.width;
    property alias textstr: roottext.text

    Text {
        id : roottext
        color: videoPlayer.bullectSettingDrawer.textColor
        font.pointSize: videoPlayer.bullectSettingDrawer.textSize
    }//弹幕文本设置
    NumberAnimation on  x{
        from : Math.random()*20
        to : endx
        duration:5000
        onStopped: root.destroy(1)
    }//x轴的变化

}
