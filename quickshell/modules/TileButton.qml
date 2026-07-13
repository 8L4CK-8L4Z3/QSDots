import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

// Reusable toggle tile for notification center
Rectangle {
  id: tile
  property string label
  property string icon
  property bool checked: false
  signal clicked()

  width: 80; height: 72; radius: M.Appearance.rounding.small
  color: checked ? M.Appearance.m3colors.m3selectionBackground : M.Appearance.m3colors.m3layerBackground2
  border.color: checked ? M.Appearance.m3colors.m3accentPrimary : "transparent"
  border.width: checked ? 1 : 0

  ColumnLayout {
    anchors.centerIn: parent
    spacing: 4
    Text {
      text: icon
      color: checked ? M.Appearance.m3colors.m3accentPrimaryText : M.Appearance.m3colors.m3secondaryText
      font.family: M.Appearance.font.family.iconFont
      font.pixelSize: M.Appearance.font.pixelSize.iconLarge
      Layout.alignment: Qt.AlignHCenter
    }
    W.StyledText {
      text: label
      color: checked ? M.Appearance.m3colors.m3accentPrimaryText : M.Appearance.m3colors.m3secondaryText
      font.pixelSize: M.Appearance.font.pixelSize.textSmall
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
