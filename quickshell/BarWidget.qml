import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "root:/modules/" as M
import "root:/modules/widgets/" as W

LayerShellWindow {
  id: barWindow
  anchors { left: true; right: true; top: true }
  exclusionMode: LayerShellExclusionMode.Exclusive
  layer: LayerShellLayer.Top
  height: M.Appearance.sizes.barHeight

  background: Rectangle {
    color: M.Appearance.m3colors.m3windowBackground
    opacity: 0.85
  }

  RowLayout {
    anchors.fill: parent
    anchors.margins: 4
    spacing: 8

    // Workspace pips
    Row {
      Layout.alignment: Qt.AlignLeft
      spacing: 3
      Repeater {
        model: Hyprland.workspaces
        Rectangle {
          width: 8; height: 8; radius: 4
          color: modelData.active
            ? M.Appearance.m3colors.m3accentPrimary
            : M.Appearance.m3colors.m3borderSecondary
        }
      }
    }

    // Active window title (using StyledText)
    W.StyledText {
      Layout.alignment: Qt.AlignLeft
      Layout.fillWidth: true
      Layout.maximumWidth: 400
      text: Hyprland.focusedWindow?.title ?? ""
      font.pixelSize: M.Appearance.font.pixelSize.textSmall
      elide: Text.ElideRight
    }

    // Fixed icons using MaterialSymbol
    W.MaterialSymbol { text: ""; iconSize: M.Appearance.font.pixelSize.iconLarge }  // volume
    W.MaterialSymbol { text: ""; iconSize: M.Appearance.font.pixelSize.iconLarge }  // battery

    // Clock (using StyledText with smaller size)
    W.StyledText {
      Layout.alignment: Qt.AlignRight
      text: new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
      font.pixelSize: M.Appearance.font.pixelSize.textSmall
      Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: parent.text = new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
      }
    }
  }
}
