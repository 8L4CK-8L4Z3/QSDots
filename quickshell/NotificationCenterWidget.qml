import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "modules" as Modules

Window {
  id: notifWindow
  width: 420
  height: 500

  Rectangle {
    anchors.fill: parent
    color: Modules.ThemeEngine.surface
    radius: 12

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8

      Text {
        text: "Notifications"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 18
        font.bold: true
      }

      GridLayout {
        columns: 4
        columnSpacing: 8
        rowSpacing: 8
        Layout.fillWidth: true

        Repeater {
          model: ["Wi-Fi", "BT", "DND", "☀", "🔒", "⏺", "🔋", "⚡"]
          Rectangle {
            width: 80; height: 64; radius: 8
            color: Modules.ThemeEngine.surfaceVariant
            Text {
              anchors.centerIn: parent
              text: modelData
              color: Modules.ThemeEngine.onSurfaceVariant
              font.pixelSize: 14
            }
          }
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "transparent"
        Text {
          anchors.centerIn: parent
          text: "No notifications"
          color: Modules.ThemeEngine.onSurfaceVariant
        }
      }
    }
  }
}
