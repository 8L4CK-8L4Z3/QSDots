import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "modules" as Modules

Window {
  id: overviewWindow
  width: 900
  height: 600

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.85)
    radius: 12

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 12

      Text {
        text: "Overview"
        color: Modules.ThemeEngine.onSurface
        font.pixelSize: 22
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
            id: wsCard
            required property var modelData
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: modelData.active ? Modules.ThemeEngine.primaryContainer : Modules.ThemeEngine.surfaceVariant
            radius: 8
            border.color: modelData.active ? Modules.ThemeEngine.primary : "transparent"
            border.width: modelData.active ? 2 : 0

            ColumnLayout {
              anchors.fill: parent
              anchors.margins: 8
              spacing: 4

              Text {
                text: "WS " + modelData.id
                color: Modules.ThemeEngine.onSurface
                font.pixelSize: 14
                font.bold: true
              }

              Repeater {
                model: {
                  var wins = [];
                  for (var i = 0; i < Hyprland.clients.length; i++) {
                    var c = Hyprland.clients[i];
                    if (c.workspace.id === modelData.id) {
                      wins.push(c);
                    }
                  }
                  return wins;
                }

                Rectangle {
                  width: parent.width
                  height: 24
                  color: Qt.hsla(0, 0, 0, 0.3)
                  radius: 4

                  Text {
                    anchors.fill: parent
                    anchors.margins: 4
                    text: modelData.title || modelData.class || "?"
                    color: Modules.ThemeEngine.onSurface
                    font.pixelSize: 10
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

      // System stats row
      RowLayout {
        Layout.fillWidth: true
        spacing: 16
        Text { text: "CPU: —"; color: Modules.ThemeEngine.onSurfaceVariant; font.pixelSize: 12 }
        Text { text: "RAM: —"; color: Modules.ThemeEngine.onSurfaceVariant; font.pixelSize: 12 }
        Text { text: "GPU: —"; color: Modules.ThemeEngine.onSurfaceVariant; font.pixelSize: 12 }
        Item { Layout.fillWidth: true }
        Text { text: new Date().toLocaleDateString(Qt.locale(), Locale.LongFormat); color: Modules.ThemeEngine.onSurfaceVariant; font.pixelSize: 12 }
      }
    }
  }

  Keys.onEscapePressed: { overviewWindow.visible = false }
}
