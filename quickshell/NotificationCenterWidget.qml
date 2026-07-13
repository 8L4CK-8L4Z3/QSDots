import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: notifWindow
  width: 420
  height: 620

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: 12

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 8

      Text {
        text: "Quick Settings"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 18
        font.bold: true
      }

      // Toggle tiles grid
      GridLayout {
        columns: 4
        columnSpacing: 8
        rowSpacing: 8
        Layout.fillWidth: true

        Modules.TileButton { label: "Wi-Fi"; icon: ""; checked: true }
        Modules.TileButton { label: "BT"; icon: ""; checked: false }
        Modules.TileButton { label: "DND"; icon: ""; checked: false }
        Modules.TileButton { label: "Dark"; icon: ""; checked: true }
        Modules.TileButton { label: "Blur"; icon: ""; checked: true }
        Modules.TileButton { label: "Rec"; icon: ""; checked: false }
        Modules.TileButton { label: "Power"; icon: ""; onClicked: xtdb.openExec("tuned.sh cycle") }
        Modules.TileButton { label: "Lock"; icon: ""; onClicked: { xtdb.openExec("hyprlock"); notifWindow.visible = false } }
      }

      // Volume slider
      RowLayout {
        Layout.fillWidth: true; spacing: 8
        Text { text: ""; color: Modules.ThemeEngine.onSurfaceVariant; font.pixelSize: 14 }
        Slider {
          id: volumeSlider
          Layout.fillWidth: true; from: 0; to: 100; value: 75
          background: Rectangle { height: 4; radius: 2; color: Modules.ThemeEngine.surface
            Rectangle { width: parent.width * volumeSlider.value / volumeSlider.to; height: 4; radius: 2; color: Modules.ThemeEngine.primary }
          }
          handle: Rectangle { width: 14; height: 14; radius: 7; color: Modules.ThemeEngine.primary; x: parent.width * volumeSlider.value / volumeSlider.to - 7 }
        }
      }
      RowLayout {
        Layout.fillWidth: true; spacing: 8
        Text { text: ""; color: Modules.ThemeEngine.onSurfaceVariant; font.pixelSize: 14 }
        Slider {
          id: brightnessSlider
          Layout.fillWidth: true; from: 0; to: 100; value: 80
          background: Rectangle { height: 4; radius: 2; color: Modules.ThemeEngine.surface
            Rectangle { width: parent.width * brightnessSlider.value / brightnessSlider.to; height: 4; radius: 2; color: Modules.ThemeEngine.secondary }
          }
          handle: Rectangle { width: 14; height: 14; radius: 7; color: Modules.ThemeEngine.secondary; x: parent.width * brightnessSlider.value / brightnessSlider.to - 7 }
        }
      }

      Rectangle { Layout.fillWidth: true; height: 1; color: Modules.ThemeEngine.outline }

      Text { text: "Notifications"; color: Modules.ThemeEngine.onSurface; font.pixelSize: 14; font.bold: true }
      Rectangle {
        Layout.fillWidth: true; Layout.fillHeight: true; color: "transparent"
        Text { anchors.centerIn: parent; text: "No notifications"; color: Modules.ThemeEngine.onSurfaceVariant }
      }

      Button {
        Layout.fillWidth: true
        text: "  Screenshot area"
        highlighted: true
        onClicked: { xtdb.openExec("grim -g \"$(slurp)\" - | satty -f -"); notifWindow.visible = false }
        contentItem: Text { text: " " + parent.text; color: "white"; horizontalAlignment: Text.AlignHCenter }
        background: Rectangle { color: Modules.ThemeEngine.primary; radius: 6 }
      }
    }
  }

  Keys.onEscapePressed: { notifWindow.visible = false }
}
