import QtQuick
import "root:/modules/" as M

/**
 * Icon component using the configured icon font.
 * Usage: MaterialSymbol { text: "..." ; iconSize: 20 }
 */
Text {
    id: root
    property real iconSize: M.Appearance.font.pixelSize.textBase
    property real fill: 0
    renderType: Text.NativeRendering
    font.hintingPreference: Font.PreferFullHinting
    verticalAlignment: Text.AlignVCenter
    font.family: M.Appearance.font.family.iconFont
    font.pixelSize: iconSize
    color: M.Appearance.m3colors.m3primaryText
}
