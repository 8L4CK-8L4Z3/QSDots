import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: wallpaperWindow
  width: 700
  height: 500

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: M.Appearance.rounding.normal

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 12

      W.StyledText {
        text: "Wallpaper Chooser"
        font.pixelSize: M.Appearance.font.pixelSize.textLarge
        font.bold: true
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: M.Appearance.m3colors.m3layerBackground1
        radius: M.Appearance.rounding.small
        W.StyledText {
          anchors.centerIn: parent
          text: "Wallpaper grid (coming in Phase 4)"
          color: M.Appearance.m3colors.m3secondaryText
        }
      }
    }
  }

  Keys.onEscapePressed: { wallpaperWindow.visible = false }
}
