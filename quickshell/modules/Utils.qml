import QtQuick

QtObject {
  function truncateText(text, maxLen) {
    if (!text) return "";
    if (text.length <= maxLen) return text;
    return text.substring(0, maxLen - 1) + "…";
  }

  function formatTime(date) {
    return date.toLocaleTimeString(Qt.locale(), Locale.ShortFormat);
  }

  function formatDate(date) {
    return date.toLocaleDateString(Qt.locale(), Locale.ShortFormat);
  }
}
