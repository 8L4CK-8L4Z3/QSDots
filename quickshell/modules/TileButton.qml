import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "ThemeEngine.qml" as ThemeImport

// Reusable toggle tile for notification center / bar
Rectangle {
  id: tile
  property string label
  property string icon
  property bool checked: false
  signal clicked()

  width: 80; height: 72; radius: 8
  color: checked ? ThemeImport.ThemeEngine.primaryContainer : ThemeImport.ThemeEngine.surfaceVariant
  border.color: checked ? ThemeImport.ThemeEngine.primary : "transparent"
  border.width: checked ? 1 : 0
  property ThemeImport.ThemeEngine theme: ThemeImport.ThemeEngine

  ColumnLayout {
    anchors.centerIn: parent
    spacing: 4
    Text {
      text: icon
      color: checked ? theme.onPrimaryContainer : theme.onSurfaceVariant
      font.pixelSize: 18
      Layout.alignment: Qt.AlignHCenter
    }
    Text {
      text: label
      color: checked ? theme.onPrimaryContainer : theme.onSurfaceVariant
      font.pixelSize: 10
      Layout.alignment: Qt.AlignHCenter
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      checked = !checked;
      tile.clicked();
    }
  }
}
