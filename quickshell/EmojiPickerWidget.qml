import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: emojiWindow
  width: 400
  height: 400

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: 10

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8

      Text {
        text: "Emoji Picker"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 16
        font.bold: true
      }

      TextField {
        id: emojiSearch
        placeholderText: "Search…"
        color: "white"
        font.pixelSize: 14
        Layout.fillWidth: true
        background: Rectangle { color: Modules.ThemeEngine.surfaceVariant; radius: 6 }
      }

      GridLayout {
        id: emojiGrid
        columns: 8
        columnSpacing: 4
        rowSpacing: 4
        Layout.fillWidth: true
        Layout.fillHeight: true

        Repeater {
          model: ["😀","😁","😂","🤣","😃","😄","😅","😆","😉","😊","😋","😎","😍","🥰","😘","😗","🤩","😢","😭","😤","😠","🤬","🤯","😳","🥶","🥵","🤔","🤗","🤭","🤐","😴","🤤","😈","👻","💀","☠️","👽","🤖","🎃","😺","😸","😹","😻","😼","🙀","🐱","🐶","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐸","🐧","🐔","🐤","🐣","🐥","🦆","🦅","🦉","🦇","🐺","🐗","🐴","🦄","🐛","🦋","🐌","🐞","🐜","🪰","🦟","🪳","🦗","🐝","🕷️","🦂","🦀","🐙","🦑","🦐","🦞","🦀","🐠","🐟","🐡","🐬","🐳","🐋","🦈","🌺","🌸","🌼","🌻","🌹","🌷","🌿","🍀","🌱","🌲","🌳","🌴","🌵","🌾","🍄","🌰","🍁","🍂","🍃","☀️","🌤️","⛅","🌧️","⛈️","🌩️","🌨️","❄️","🌊","🔥","⭐","🌙","☁️","🌈","⚡"]

          Text {
            text: modelData
            font.pixelSize: 22
            width: 40; height: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            MouseArea {
              anchors.fill: parent
              onClicked: {
                xtdb.openExec("wl-copy " + parent.text);
                emojiWindow.visible = false;
              }
            }
          }
        }
      }
    }
  }

  Keys.onEscapePressed: { emojiWindow.visible = false }
}
