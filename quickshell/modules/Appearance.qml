import QtQuick
import Quickshell
pragma Singleton
pragma ComponentBehavior: Bound

/**
 * Central styling singleton — colors, fonts, sizes, rounding.
 * Colors are loaded from theme.json by ThemeEngine.
 * Font config is loaded from config.json by Loader (future). 
 * Components import "modules" as M and use M.Appearance.*.
 */

Singleton {
    id: root

    property QtObject m3colors: QtObject {
        property bool darkmode: true
        property bool transparent: true
        property color m3windowBackground: "#121212"
        property color m3primaryText: "#ffffff"
        property color m3layerBackground1: "#1e1e1e"
        property color m3layerBackground2: "#2d2d2d"
        property color m3layerBackground3: "#383838"
        property color m3surfaceText: "#e0e0e0"
        property color m3secondaryText: "#b0b0b0"
        property color m3borderPrimary: "#bb86fc"
        property color m3shadowColor: "#000000"
        property color m3accentPrimary: "#bb86fc"
        property color m3accentSecondary: "#03dac6"
        property color m3selectionBackground: "#534457"
        property color m3accentPrimaryText: "#000000"
        property color m3selectionText: "#ffffff"
        property color m3borderSecondary: "#555555"
        property color m3error: "#cf6679"
    }

    property QtObject font: QtObject {
        property QtObject family: QtObject {
            property string uiFont: "CaskaydiaCove Nerd Font"
            property string iconFont: "CaskaydiaCove Nerd Font"
            property string codeFont: "CaskaydiaCove Nerd Font Mono"
        }
        property QtObject pixelSize: QtObject {
            property int textSmall: 11
            property int textBase: 13
            property int textMedium: 15
            property int textLarge: 18
            property int iconLarge: 20
        }
    }

    property QtObject rounding: QtObject {
        property int unsharpen: 2
        property int verysmall: 6
        property int small: 8
        property int normal: 10
        property int large: 14
        property int verylarge: 20
        property int full: 9999
    }

    property QtObject sizes: QtObject {
        property real barHeight: 36
        property real notificationPopupWidth: 410
    }
}
