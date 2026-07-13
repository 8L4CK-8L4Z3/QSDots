import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: settingsWindow
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
        text: "Settings"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 20
        font.bold: true
      }

      Item { Layout.fillHeight: true }

      Text { text: "Profile: caelestia"; color: Modules.ThemeEngine.onSurfaceVariant }
      Text { text: "Blur: on  |  Transparency: 0.85"; color: Modules.ThemeEngine.onSurfaceVariant }
    }
  }
}
