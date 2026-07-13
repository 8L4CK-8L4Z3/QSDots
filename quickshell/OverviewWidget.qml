import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: overviewWindow
  width: 900
  height: 600

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.85)
    radius: M.Appearance.rounding.large

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 12

      W.StyledText {
        text: "Overview"
        font.pixelSize: M.Appearance.font.pixelSize.textLarge
        font.bold: true
      }

      GridLayout {
        id: workspaceGrid
        columns: 5
        columnSpacing: 10
        rowSpacing: 10
        Layout.fillWidth: true
        Layout.fillHeight: true

        Repeater {
          model: Hyprland.workspaces

          Rectangle {
            required property var modelData
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: modelData.active
              ? M.Appearance.m3colors.m3selectionBackground
              : M.Appearance.m3colors.m3layerBackground2
            radius: M.Appearance.rounding.small
            border.color: modelData.active
              ? M.Appearance.m3colors.m3accentPrimary
              : "transparent"
            border.width: modelData.active ? 2 : 0

            ColumnLayout {
              anchors.fill: parent
              anchors.margins: 8
              spacing: 4

              W.StyledText {
                text: "WS " + modelData.id
                font.pixelSize: M.Appearance.font.pixelSize.textMedium
                font.bold: true
              }

              Repeater {
                model: {
                  var wins = [];
                  for (var i = 0; i < Hyprland.clients.length; i++) {
                    var c = Hyprland.clients[i];
                    if (c.workspace.id === modelData.id) wins.push(c);
                  }
                  return wins;
                }

                Rectangle {
                  width: parent.width
                  height: 24
                  color: Qt.hsla(0, 0, 0, 0.3)
                  radius: M.Appearance.rounding.unsharpen
                  W.StyledText {
                    anchors.fill: parent
                    anchors.margins: 4
                    text: modelData.title || modelData.class || "?"
                    font.pixelSize: M.Appearance.font.pixelSize.textSmall
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                  }
                }
              }

              Item { Layout.fillHeight: true }
            }

            MouseArea {
              anchors.fill: parent
              onClicked: {
                Hyprland.focusWorkspace(modelData.id);
                overviewWindow.visible = false;
              }
            }
          }
        }
      }

      RowLayout {
        Layout.fillWidth: true
        spacing: 16
        W.StyledText { text: "CPU: —"; font.pixelSize: M.Appearance.font.pixelSize.textSmall; color: M.Appearance.m3colors.m3secondaryText }
        W.StyledText { text: "RAM: —"; font.pixelSize: M.Appearance.font.pixelSize.textSmall; color: M.Appearance.m3colors.m3secondaryText }
        Item { Layout.fillWidth: true }
        W.StyledText {
          text: new Date().toLocaleDateString(Qt.locale(), Locale.LongFormat)
          font.pixelSize: M.Appearance.font.pixelSize.textSmall
          color: M.Appearance.m3colors.m3secondaryText
        }
      }
    }
  }

  Keys.onEscapePressed: { overviewWindow.visible = false }
}
