import QtQuick
import Quickshell
pragma Singleton
pragma ComponentBehavior: Bound

/**
 * Path utilities for shell configuration.
 */
Singleton {
    id: root

    readonly property string shellConfigDir: Quickshell.paths.configDir + "/quickshell"
    readonly property string generatedMaterialThemePath: shellConfigDir + "/theme.json"
}
