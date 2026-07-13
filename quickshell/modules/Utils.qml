import QtQuick
import Quickshell.Io

QtObject {
  property Process _proc: Process { }

  function openExec(cmd) {
    _proc.command = "/bin/sh";
    _proc.args = ["-c", cmd];
    _proc.running = true;
  }

  function truncateText(text, maxLen) {
    if (!text) return "";
    if (text.length <= maxLen) return text;
    return text.substring(0, maxLen - 1) + "\u2026";
  }

  function formatTime(date) {
    return date.toLocaleTimeString(Qt.locale(), Locale.ShortFormat);
  }

  function formatDate(date) {
    return date.toLocaleDateString(Qt.locale(), Locale.ShortFormat);
  }
}
