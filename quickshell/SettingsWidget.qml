import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: settingsWindow
  width: 700
  height: 500

  signal openWallpaperChooser()

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: M.Appearance.rounding.normal

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 24
      spacing: 16

      W.StyledText {
        text: "Settings"
        font.pixelSize: M.Appearance.font.pixelSize.textLarge
        font.bold: true
      }

      GroupBox {
        Layout.fillWidth: true
        label: W.StyledText { text: "Theme Profile"; font.bold: true; color: M.Appearance.m3colors.m3accentPrimary }

        RowLayout {
          spacing: 12
          Button {
            text: "caelestia"; highlighted: true
            onClicked: M.Utils.openExec("profiles/switch-profile.sh caelestia")
            contentItem: W.StyledText {
              text: parent.text; horizontalAlignment: Text.AlignHCenter
              color: M.Appearance.m3colors.m3accentPrimaryText
            }
            background: Rectangle { color: M.Appearance.m3colors.m3accentPrimary; radius: M.Appearance.rounding.small }
          }
          Button {
            text: "jakoolit"
            onClicked: M.Utils.openExec("profiles/switch-profile.sh jakoolit")
            contentItem: W.StyledText {
              text: parent.text; horizontalAlignment: Text.AlignHCenter
              color: M.Appearance.m3colors.m3accentPrimary
            }
            background: Rectangle {
              color: "transparent"; radius: M.Appearance.rounding.small
              border.color: M.Appearance.m3colors.m3accentPrimary; border.width: 1
            }
          }
        }
      }

      GroupBox {
        Layout.fillWidth: true
        label: W.StyledText { text: "Visual"; font.bold: true; color: M.Appearance.m3colors.m3accentPrimary }

        ColumnLayout {
          spacing: 12; Layout.fillWidth: true

          RowLayout {
            spacing: 12
            W.StyledText { text: "Blur" }
            Switch {
              checked: true
              onToggled: M.Utils.openExec("hyprctl keyword decoration:blur:enabled " + (checked ? "true" : "false"))
            }
          }

          RowLayout {
            spacing: 12
            W.StyledText { text: "Opacity" }
            Slider {
              id: opacitySlider; Layout.fillWidth: true
              from: 0.5; to: 1.0; value: 0.9; stepSize: 0.05
              onValueChanged: {
                M.Utils.openExec("hyprctl keyword decoration:active_opacity " + value);
                M.Utils.openExec("hyprctl keyword decoration:inactive_opacity " + (value - 0.1));
              }
              background: Rectangle {
                height: 4; radius: 2; color: M.Appearance.m3colors.m3layerBackground3
                Rectangle {
                  width: parent.width * (opacitySlider.value - opacitySlider.from) / (opacitySlider.to - opacitySlider.from)
                  height: 4; radius: 2; color: M.Appearance.m3colors.m3accentPrimary
                }
              }
              handle: Rectangle {
                width: 14; height: 14; radius: 7; color: M.Appearance.m3colors.m3accentPrimary
                x: parent.width * (opacitySlider.value - opacitySlider.from) / (opacitySlider.to - opacitySlider.from) - 7
              }
            }
          }
        }
      }

      GroupBox {
        Layout.fillWidth: true
        label: W.StyledText { text: "Wallpaper"; font.bold: true; color: M.Appearance.m3colors.m3accentPrimary }

        RowLayout {
          spacing: 12
          Button {
            text: "Randomize"; highlighted: true
            onClicked: M.Utils.openExec("~/.config/scripts/set-wallpaper.sh ~/Pictures/Wallpapers/$(ls ~/Pictures/Wallpapers/ | shuf -n1)")
            contentItem: W.StyledText {
              text: parent.text; horizontalAlignment: Text.AlignHCenter
              color: M.Appearance.m3colors.m3accentPrimaryText
            }
            background: Rectangle { color: M.Appearance.m3colors.m3accentPrimary; radius: M.Appearance.rounding.small }
          }
          Button {
            text: "Open chooser"
            onClicked: { settingsWindow.visible = false; openWallpaperChooser() }
            contentItem: W.StyledText {
              text: parent.text; horizontalAlignment: Text.AlignHCenter
              color: M.Appearance.m3colors.m3accentPrimary
            }
            background: Rectangle {
              color: "transparent"; radius: M.Appearance.rounding.small
              border.color: M.Appearance.m3colors.m3accentPrimary; border.width: 1
            }
          }
        }
      }

      Item { Layout.fillHeight: true }
    }
  }

  Keys.onEscapePressed: { settingsWindow.visible = false }
}
