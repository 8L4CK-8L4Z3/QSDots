import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: emojiWindow
  width: 400
  height: 400

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: M.Appearance.rounding.normal

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8

      W.StyledText {
        text: "Emoji Picker"
        font.pixelSize: M.Appearance.font.pixelSize.textMedium
        font.bold: true
      }

      TextField {
        id: emojiSearch
        placeholderText: "Search…"
        color: M.Appearance.m3colors.m3primaryText
        font.pixelSize: M.Appearance.font.pixelSize.textBase
        font.family: M.Appearance.font.family.uiFont
        Layout.fillWidth: true
        background: Rectangle { color: M.Appearance.m3colors.m3layerBackground1; radius: M.Appearance.rounding.small }
      }

      GridLayout {
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
