import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "modules" as Modules

Window {
  id: overviewWindow
  width: 800
  height: 600

  Rectangle {
    anchors.fill: parent
    color: Modules.ThemeEngine.surfaceVariant
    radius: 12

    Text {
      anchors.centerIn: parent
      text: "Overview"
      color: Modules.ThemeEngine.onSurface
      font.pixelSize: 24
    }
  }
}
