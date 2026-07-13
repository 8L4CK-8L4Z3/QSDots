import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules" as Modules

Window {
  id: appSearch
  width: 500
  height: 60

  Rectangle {
    anchors.fill: parent
    color: Modules.ThemeEngine.surface
    radius: 8
    border.color: Modules.ThemeEngine.outline
    border.width: 1

    TextField {
      id: searchField
      anchors.fill: parent
      anchors.margins: 8
      placeholderText: "Search applications…"
      color: Modules.ThemeEngine.onSurface
      font.pixelSize: 16
      background: Rectangle { color: "transparent" }

      Keys.onEscapePressed: { appSearch.visible = false }
      Keys.onReturnPressed: {
        if (text.length > 0) {
          Qt.openUrlExternally("https://www.google.com/search?q=" + encodeURIComponent(text));
        }
        appSearch.visible = false;
      }
    }
  }
}
