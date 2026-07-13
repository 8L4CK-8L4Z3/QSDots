import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: calcWindow
  width: 280
  height: 360

  property var calcBtns: [ ["7","8","9","/"], ["4","5","6","*"], ["1","2","3","-"], ["0",".","=","+"] ]
  property string calcExpr: ""

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: 10

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
        color: "white"
        font.pixelSize: 24
        horizontalAlignment: Text.AlignRight
        background: Rectangle { color: Modules.ThemeEngine.surfaceVariant; radius: 6 }
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
          }
        }
      }

      Button {
        Layout.fillWidth: true
        text: "Clear"
        highlighted: true
        onClicked: { calcDisplay.text = "0"; calcExpr = ""; }
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
