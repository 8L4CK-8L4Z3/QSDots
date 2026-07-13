import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: wallpaperWindow
  width: 700
  height: 500

  Rectangle {
    anchors.fill: parent
    color: Modules.ThemeEngine.surfaceVariant
    radius: 10

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 12

      Text {
        text: "Wallpaper Chooser"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 20
        font.bold: true
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: Modules.ThemeEngine.surface
        radius: 8
        Text {
          anchors.centerIn: parent
          text: "Wallpaper grid (coming in Phase 4)"
          color: Modules.ThemeEngine.onSurfaceVariant
        }
      }
    }
  }
}
