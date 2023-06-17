/**
 * 主页工具栏按钮
 */

import QtQuick
import QtQuick.Controls
import "../logic"

Button {
    property string iconSource: ""
    property string toolTip: " "

    property bool isCheckable: false
    property bool isChecked: false

    icon.width: 20
    icon.height: 20

    id: self

    icon.source: iconSource

    HomeToolTip {
        visible: parent.hovered
        text: toolTip
    }

    background: Rectangle {
        color: self.down || (isCheckable && self.checked) ? "#eeeeee" : "#00000000"
    }
    icon.color: self.down || (isCheckable && self.checked) ? "#000000" : "#333333"

    checkable: isCheckable
    checked: isChecked
}




