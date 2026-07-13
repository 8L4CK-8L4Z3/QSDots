import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: appSearch
  width: 500
  height: 60

  Rectangle {
    anchors.fill: parent
    color: M.Appearance.m3colors.m3layerBackground1
    radius: M.Appearance.rounding.small
    border.color: M.Appearance.m3colors.m3borderSecondary
    border.width: 1

    TextField {
      id: searchField
      anchors.fill: parent
      anchors.margins: 8
      placeholderText: "Search applications…"
      color: M.Appearance.m3colors.m3primaryText
      font.pixelSize: M.Appearance.font.pixelSize.textMedium
      font.family: M.Appearance.font.family.uiFont
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
