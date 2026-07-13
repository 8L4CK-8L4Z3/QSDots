import QtQuick

QtObject {
  id: theme

  property string colorScheme: "dark"

  property color primary: "#bb86fc"
  property color onPrimary: "#000000"
  property color primaryContainer: "#3700b3"
  property color onPrimaryContainer: "#ffffff"
  property color secondary: "#03dac6"
  property color onSecondary: "#000000"
  property color secondaryContainer: "#018786"
  property color onSecondaryContainer: "#ffffff"
  property color surface: "#121212"
  property color onSurface: "#ffffff"
  property color surfaceVariant: "#1e1e1e"
  property color onSurfaceVariant: "#c4c4c4"
  property color background: "#000000"
  property color onBackground: "#ffffff"
  property color error: "#cf6679"
  property color onError: "#000000"
  property color outline: "#938f99"

  property real barOpacity: 0.85
  property real popupOpacity: 0.92
  property real widgetOpacity: 0.8

  Component.onCompleted: {
    // Load palette from ../theme.json (parent of modules/ = quickshell dir)
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../theme.json", false);
    try {
      xhr.send();
      if (xhr.status === 0 || xhr.status === 200) {
        var data = JSON.parse(xhr.responseText);
        applyPalette(data);
      }
    } catch (e) {
      console.log("ThemeEngine: using fallback palette");
    }
  }

  function applyPalette(data) {
    if (data.primary) primary = data.primary;
    if (data.onPrimary) onPrimary = data.onPrimary;
    if (data.primaryContainer) primaryContainer = data.primaryContainer;
    if (data.onPrimaryContainer) onPrimaryContainer = data.onPrimaryContainer;
    if (data.secondary) secondary = data.secondary;
    if (data.onSecondary) onSecondary = data.onSecondary;
    if (data.surface) surface = data.surface;
    if (data.onSurface) onSurface = data.onSurface;
    if (data.background) background = data.background;
    if (data.onBackground) onBackground = data.onBackground;
    if (data.error) error = data.error;
    if (data.onError) onError = data.onError;
    if (data.colorScheme) colorScheme = data.colorScheme;
  }
}
