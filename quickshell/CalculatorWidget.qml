import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: calcWindow
  width: 280
  height: 360

  property var calcBtns: [ ["7","8","9","/"], ["4","5","6","*"], ["1","2","3","-"], ["0",".","=","+"] ]
  property string calcExpr: ""

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: M.Appearance.rounding.normal

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8

      TextField {
        id: calcDisplay
        Layout.fillWidth: true
        height: 48
        readOnly: true
        text: "0"
        color: M.Appearance.m3colors.m3primaryText
        font.pixelSize: 24
        font.family: M.Appearance.font.family.codeFont
        horizontalAlignment: Text.AlignRight
        background: Rectangle { color: M.Appearance.m3colors.m3layerBackground1; radius: M.Appearance.rounding.small }
      }

      GridLayout {
        columns: 4
        columnSpacing: 6
        rowSpacing: 6
        Layout.fillWidth: true
        Layout.fillHeight: true

        Repeater {
          model: 16
          Button {
            required property int index
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: {
              var row = Math.floor(index / 4);
              var col = index % 4;
              return calcWindow.calcBtns[row][col];
            }
            highlighted: ["/","*","-","+","="].indexOf(text) >= 0
            onClicked: calcWindow.handleButton(text)
            font.pixelSize: M.Appearance.font.pixelSize.textMedium
            background: Rectangle {
              color: parent.highlighted ? M.Appearance.m3colors.m3accentPrimary : M.Appearance.m3colors.m3layerBackground2
              radius: M.Appearance.rounding.small
            }
            contentItem: Text {
              text: parent.text
              color: parent.highlighted ? M.Appearance.m3colors.m3accentPrimaryText : M.Appearance.m3colors.m3primaryText
              font.pixelSize: parent.font.pixelSize
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
            }
          }
        }
      }

      Button {
        Layout.fillWidth: true
        text: "Clear"
        onClicked: { calcDisplay.text = "0"; calcExpr = ""; }
        contentItem: W.StyledText {
          text: "Clear"; horizontalAlignment: Text.AlignHCenter
          color: M.Appearance.m3colors.m3accentPrimaryText
        }
        background: Rectangle {
          color: M.Appearance.m3colors.m3error; radius: M.Appearance.rounding.small
        }
      }
    }
  }

  function handleButton(btn) {
    if (btn === "=") {
      try {
        calcDisplay.text = eval(calcExpr).toString();
        calcExpr = calcDisplay.text;
      } catch (e) {
        calcDisplay.text = "Error";
        calcExpr = "";
      }
    } else if (["/","*","-","+"].indexOf(btn) >= 0) {
      calcExpr += btn;
      calcDisplay.text += btn;
    } else {
      if (calcDisplay.text === "0") calcDisplay.text = "";
      calcDisplay.text += btn;
      calcExpr += btn;
    }
  }

  Keys.onEscapePressed: { calcWindow.visible = false }
}
