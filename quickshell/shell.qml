//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "root:/modules/" as M
import "root:/modules/widgets/" as W

ShellRoot {
  id: shell

  Component.onCompleted: {
    // force ThemeEngine singleton init (starts watching theme.json)
    M.ThemeEngine.reapplyTheme();

    Quickshell.registerGlobalShortcut("quickshell:appSearch", shell, () => { appSearch.visible = !appSearch.visible; });
    Quickshell.registerGlobalShortcut("quickshell:overviewToggle", shell, () => { overview.visible = !overview.visible; });
    Quickshell.registerGlobalShortcut("quickshell:notificationCenter", shell, () => { notifCenter.visible = !notifCenter.visible; });
    Quickshell.registerGlobalShortcut("quickshell:helpMenu", shell, () => { helpMenu.visible = !helpMenu.visible; });
    Quickshell.registerGlobalShortcut("quickshell:settings", shell, () => { settingsApp.visible = !settingsApp.visible; });
    Quickshell.registerGlobalShortcut("quickshell:wallpaperPicker", shell, () => { wallpaperChooser.visible = !wallpaperChooser.visible; });
    Quickshell.registerGlobalShortcut("quickshell:emojiPicker", shell, () => { emojiPicker.visible = !emojiPicker.visible; });
    Quickshell.registerGlobalShortcut("quickshell:calculator", shell, () => { calculator.visible = !calculator.visible; });
  }

  // All component instances
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
