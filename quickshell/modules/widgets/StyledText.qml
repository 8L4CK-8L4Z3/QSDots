import QtQuick
import "root:/modules/" as M

/**
 * UI text component using the configured UI font.
 */
Text {
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    font {
        hintingPreference: Font.PreferFullHinting
        family: M.Appearance.font.family.uiFont
        pixelSize: M.Appearance.font.pixelSize.textBase
    }
    color: M.Appearance.m3colors.m3primaryText
}
