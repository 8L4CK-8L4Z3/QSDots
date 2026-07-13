import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "modules" as Modules

LayerShellWindow {
  id: barWindow

  anchors {
    left: true
    right: true
    top: true
  }

  exclusionMode: LayerShellExclusionMode.Exclusive
  layer: LayerShellLayer.Top
  height: 36

  background: Rectangle {
    color: Qt.hsla(0, 0, 0, 0.75)
  }

  RowLayout {
    anchors.fill: parent
    anchors.margins: 4
    spacing: 8

    // Workspace pips
    Row {
      Layout.alignment: Qt.AlignLeft
      spacing: 2
      Repeater {
        model: Hyprland.workspaces
        Rectangle {
          width: 8
          height: 8
          radius: 4
          color: modelData.active ? "#bb86fc" : "#555"
        }
      }
    }

    // Active window title
    Text {
      Layout.alignment: Qt.AlignLeft
      Layout.fillWidth: true
      Layout.maximumWidth: 400
      text: Hyprland.focusedWindow?.title ?? ""
      color: "white"
      font.pixelSize: 12
      elide: Text.ElideRight
    }

    // Clock
    Text {
      Layout.alignment: Qt.AlignRight
      text: new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
      color: "white"
      font.pixelSize: 12
      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: parent.text = new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
      }
    }
  }
}
