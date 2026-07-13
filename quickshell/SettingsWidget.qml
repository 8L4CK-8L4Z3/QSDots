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
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: 10

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 24
      spacing: 16

      Text {
        text: "Settings"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 22
        font.bold: true
      }

      // Profile selection
      GroupBox {
        title: "Theme Profile"
        Layout.fillWidth: true
        label: Text { text: "Theme Profile"; color: Modules.ThemeEngine.primary; font.bold: true }

        RowLayout {
          spacing: 12
          Button {
            text: "caelestia"
            highlighted: true
            onClicked: {
              xtdb.openExec("profiles/switch-profile.sh caelestia");
            }
          }
          Button {
            text: "jakoolit"
            onClicked: {
              xtdb.openExec("profiles/switch-profile.sh jakoolit");
            }
          }
        }
      }

      // Visual settings
      GroupBox {
        title: "Visual"
        Layout.fillWidth: true
        label: Text { text: "Visual"; color: Modules.ThemeEngine.primary; font.bold: true }

        ColumnLayout {
          spacing: 12
          Layout.fillWidth: true

          // Blur toggle
          RowLayout {
            spacing: 12
            Text { text: "Blur"; color: Modules.ThemeEngine.onSurface }
            Switch {
              checked: true
              onToggled: {
                xtdb.openExec("hyprctl keyword decoration:blur:enabled " + (checked ? "true" : "false"));
              }
            }
          }

          // Transparency slider
          RowLayout {
            spacing: 12
            Text { text: "Opacity"; color: Modules.ThemeEngine.onSurface }
            Slider {
              id: opacitySlider
              Layout.fillWidth: true
              from: 0.5; to: 1.0; value: 0.9; stepSize: 0.05
              onValueChanged: {
                xtdb.openExec("hyprctl keyword decoration:active_opacity " + value);
                xtdb.openExec("hyprctl keyword decoration:inactive_opacity " + (value - 0.1));
              }
            }
          }
        }
      }

      // Wallpaper
      GroupBox {
        title: "Wallpaper"
        Layout.fillWidth: true
        label: Text { text: "Wallpaper"; color: Modules.ThemeEngine.primary; font.bold: true }

        RowLayout {
          spacing: 12
          Button {
            text: "Randomize"
            onClicked: {
              xtdb.openExec("~/.config/scripts/set-wallpaper.sh ~/Pictures/Wallpapers/$(ls ~/Pictures/Wallpapers/ | shuf -n1)");
            }
          }
          Button {
            text: "Open chooser"
            onClicked: {
              settingsWindow.visible = false;
              wallpaperChooser.visible = true;
            }
          }
        }
      }

      Item { Layout.fillHeight: true }
    }
  }

  Keys.onEscapePressed: { settingsWindow.visible = false }
}
