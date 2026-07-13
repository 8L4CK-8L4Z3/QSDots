import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/modules/" as M
import "root:/modules/widgets/" as W

Window {
  id: helpWindow
  width: 640
  height: 500

  Rectangle {
    anchors.fill: parent
    color: Qt.hsla(0, 0, 0, 0.88)
    radius: M.Appearance.rounding.normal

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 12

      W.StyledText {
        text: "Keybinds & Help"
        font.pixelSize: M.Appearance.font.pixelSize.textLarge
        font.bold: true
      }

      ListView {
        id: keybindList
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        spacing: 2
        model: keybindModel
        delegate: Rectangle {
          width: parent.width
          height: 36
          color: index % 2 === 0 ? Qt.hsla(0, 0, 0, 0.15) : "transparent"
          radius: M.Appearance.rounding.unsharpen
          RowLayout {
            anchors.fill: parent; anchors.margins: 8; spacing: 16
            W.StyledText {
              Layout.preferredWidth: 220
              text: model.group ? ("\u2501 " + model.group) : model.keys
              color: model.group ? M.Appearance.m3colors.m3accentPrimary : M.Appearance.m3colors.m3primaryText
              font.family: model.group ? M.Appearance.font.family.uiFont : M.Appearance.font.family.codeFont
              font.pixelSize: model.group ? M.Appearance.font.pixelSize.textMedium : M.Appearance.font.pixelSize.textBase
              font.bold: model.group ? true : false
            }
            W.StyledText {
              Layout.fillWidth: true
              text: model.desc
              color: model.group ? M.Appearance.m3colors.m3accentPrimary : M.Appearance.m3colors.m3secondaryText
              font.pixelSize: M.Appearance.font.pixelSize.textBase
            }
          }
        }
      }
    }
  }

  property var keybindModel: ListModel {}

  function loadKeybinds() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../keybinds.json", false);
    try {
      xhr.send();
      if (xhr.status === 0 || xhr.status === 200) {
        var data = JSON.parse(xhr.responseText);
        keybindModel.clear();
        for (var g = 0; g < data.groups.length; g++) {
          var group = data.groups[g];
          keybindModel.append({ keys: "", desc: "", group: group.name });
          for (var b = 0; b < group.binds.length; b++) {
            var bind = group.binds[b];
            var keysStr = bind.keys.map(function(k) {
              return k.charAt(0).toUpperCase() + k.slice(1).toLowerCase();
            }).join("+");
            keybindModel.append({ keys: keysStr, desc: bind.desc, group: "" });
          }
        }
      }
    } catch (e) {
      console.log("HelpMenu: could not load keybinds.json");
      keybindModel.append({ keys: "failed to load", desc: "keybinds.json not found", group: "" });
    }
  }

  Component.onCompleted: loadKeybinds()
  Keys.onEscapePressed: { helpWindow.visible = false }
}
