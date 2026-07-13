import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: notifWindow
  width: 420
  height: 620

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: M.Appearance.rounding.large

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 8

      // Header
      W.StyledText {
        text: "Quick Settings"
        font.pixelSize: M.Appearance.font.pixelSize.textMedium
        font.bold: true
      }

      // Toggle tiles
      GridLayout {
        columns: 4
        columnSpacing: 8
        rowSpacing: 8
        Layout.fillWidth: true

        M.TileButton { label: "Wi-Fi"; icon: "\uF087"; checked: true }
        M.TileButton { label: "BT"; icon: "\uF293"; checked: false }
        M.TileButton { label: "DND"; icon: "\uF1F6"; checked: false }
        M.TileButton { label: "Dark"; icon: "\uF186"; checked: true }
        M.TileButton { label: "Blur"; icon: "\uF0C2"; checked: true }
        M.TileButton { label: "Rec"; icon: "\uF03D"; checked: false }
        M.TileButton { label: "Power"; icon: "\uF0E7"; onClicked: M.Utils.openExec("tuned.sh cycle") }
        M.TileButton { label: "Lock"; icon: "\uF023"; onClicked: { M.Utils.openExec("hyprlock"); notifWindow.visible = false } }
      }

      // Volume
      RowLayout {
        Layout.fillWidth: true; spacing: 8
        W.MaterialSymbol { text: "\uF028"; iconSize: M.Appearance.font.pixelSize.textBase }
        Slider {
          id: volumeSlider
          Layout.fillWidth: true; from: 0; to: 100; value: 75
          background: Rectangle {
            height: 4; radius: 2; color: M.Appearance.m3colors.m3layerBackground3
            Rectangle {
              width: parent.width * volumeSlider.value / volumeSlider.to
              height: 4; radius: 2; color: M.Appearance.m3colors.m3accentPrimary
            }
          }
          handle: Rectangle {
            width: 14; height: 14; radius: 7
            color: M.Appearance.m3colors.m3accentPrimary
            x: parent.width * volumeSlider.value / volumeSlider.to - 7
          }
        }
      }

      // Brightness
      RowLayout {
        Layout.fillWidth: true; spacing: 8
        W.MaterialSymbol { text: "\uF185"; iconSize: M.Appearance.font.pixelSize.textBase }
        Slider {
          id: brightnessSlider
          Layout.fillWidth: true; from: 0; to: 100; value: 80
          background: Rectangle {
            height: 4; radius: 2; color: M.Appearance.m3colors.m3layerBackground3
            Rectangle {
              width: parent.width * brightnessSlider.value / brightnessSlider.to
              height: 4; radius: 2; color: M.Appearance.m3colors.m3accentSecondary
            }
          }
          handle: Rectangle {
            width: 14; height: 14; radius: 7
            color: M.Appearance.m3colors.m3accentSecondary
            x: parent.width * brightnessSlider.value / brightnessSlider.to - 7
          }
        }
      }

      Rectangle { Layout.fillWidth: true; height: 1; color: M.Appearance.m3colors.m3borderSecondary }

      W.StyledText { text: "Notifications"; font.pixelSize: M.Appearance.font.pixelSize.textSmall; font.bold: true }
      Rectangle {
        Layout.fillWidth: true; Layout.fillHeight: true; color: "transparent"
        W.StyledText { anchors.centerIn: parent; text: "No notifications"; color: M.Appearance.m3colors.m3secondaryText }
      }

      Button {
        Layout.fillWidth: true
        highlighted: true
        onClicked: { M.Utils.openExec("grim -g \"$(slurp)\" - | satty -f -"); notifWindow.visible = false }
        contentItem: W.StyledText {
          text: "\uF030  Screenshot area"
          horizontalAlignment: Text.AlignHCenter
          color: M.Appearance.m3colors.m3accentPrimaryText
        }
        background: Rectangle { color: M.Appearance.m3colors.m3accentPrimary; radius: M.Appearance.rounding.small }
      }
    }
  }

  Keys.onEscapePressed: { notifWindow.visible = false }
}
