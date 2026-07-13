import QtQuick
import "root:/modules/" as M

/**
 * Styled rectangle with configurable color and rounding.
 */
Rectangle {
    radius: M.Appearance.rounding.small
    color: M.Appearance.m3colors.m3layerBackground2
}
