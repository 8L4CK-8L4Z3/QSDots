//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "modules" as Modules

ShellRoot {
  property Modules.ThemeEngine theme: Modules.ThemeEngine {}

  Component.onCompleted: {
    Quickshell.registerGlobalShortcut("quickshell:appSearch", () => { appSearch.visible = !appSearch.visible; });
    Quickshell.registerGlobalShortcut("quickshell:overviewToggle", () => { overview.visible = !overview.visible; });
    Quickshell.registerGlobalShortcut("quickshell:notificationCenter", () => { notifCenter.visible = !notifCenter.visible; });
    Quickshell.registerGlobalShortcut("quickshell:helpMenu", () => { helpMenu.visible = !helpMenu.visible; });
    Quickshell.registerGlobalShortcut("quickshell:settings", () => { settingsApp.visible = !settingsApp.visible; });
    Quickshell.registerGlobalShortcut("quickshell:wallpaperPicker", () => { wallpaperChooser.visible = !wallpaperChooser.visible; });
    Quickshell.registerGlobalShortcut("quickshell:emojiPicker", () => { emojiPicker.visible = !emojiPicker.visible; });
    Quickshell.registerGlobalShortcut("quickshell:calculator", () => { calculator.visible = !calculator.visible; });
  }

  BarWidget { id: bar }
  AppSearchWidget { id: appSearch; visible: false }
  OverviewWidget { id: overview; visible: false }
  NotificationCenterWidget { id: notifCenter; visible: false }
  HelpMenuWidget { id: helpMenu; visible: false }
  SettingsWidget { id: settingsApp; visible: false }
  WallpaperChooserWidget { id: wallpaperChooser; visible: false }
  EmojiPickerWidget { id: emojiPicker; visible: false }
  CalculatorWidget { id: calculator; visible: false }
}
