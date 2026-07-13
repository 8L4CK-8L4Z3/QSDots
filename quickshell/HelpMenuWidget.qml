import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: helpWindow
  width: 600
  height: 500

  Rectangle {
    anchors.fill: parent
    color: Modules.ThemeEngine.surface
    radius: 10

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 8

      Text {
        text: "Keybinds & Help"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 20
        font.bold: true
      }

      ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: ListModel {
          ListElement { keys: "Super+Return"; desc: "Open terminal" }
          ListElement { keys: "Super+D"; desc: "App launcher" }
          ListElement { keys: "Super+A"; desc: "Overview" }
          ListElement { keys: "Super+N"; desc: "Notification center" }
          ListElement { keys: "Super+H"; desc: "Help menu" }
          ListElement { keys: "Super+W"; desc: "Wallpaper chooser" }
          ListElement { keys: "Super+,"; desc: "Settings" }
          ListElement { keys: "Super+1-0"; desc: "Switch workspace" }
          ListElement { keys: "Super+Q"; desc: "Close window" }
          ListElement { keys: "Super+F"; desc: "Toggle fullscreen" }
          ListElement { keys: "Super+Space"; desc: "Toggle float" }
          ListElement { keys: "Super+E"; desc: "File manager" }
          ListElement { keys: "Super+Shift+P"; desc: "Cycle power profile" }
          ListElement { keys: "Print"; desc: "Screenshot area" }
        }
        delegate: Rectangle {
          width: parent.width
          height: 32
          color: "transparent"
          RowLayout {
            anchors.fill: parent
            spacing: 16
            Text {
              Layout.preferredWidth: 200
              text: keys
              color: Modules.ThemeEngine.primary
              font.family: "monospace"
              font.pixelSize: 13
            }
            Text {
              Layout.fillWidth: true
              text: desc
              color: Modules.ThemeEngine.onSurface
              font.pixelSize: 13
            }
          }
        }
      }
    }
  }
}
