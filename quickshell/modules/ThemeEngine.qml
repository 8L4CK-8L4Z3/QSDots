import QtQuick
import Quickshell
import Quickshell.Io
import "root:/modules/" as M
pragma Singleton
pragma ComponentBehavior: Bound

/**
 * Automatically reloads generated material colors from theme.json.
 * Call reapplyTheme() at shell startup (singletons are lazy).
 */
Singleton {
    id: root

    property string filePath: M.Directories.generatedMaterialThemePath

    function reapplyTheme() {
        themeFileView.reload();
    }

    function applyColors(fileContent) {
        try {
            const json = JSON.parse(fileContent);
            for (const key in json) {
                if (json.hasOwnProperty(key)) {
                    const camelCaseKey = key.replace(/_([a-z])/g, (g) => g[1].toUpperCase());
                    const m3Key = "m3" + camelCaseKey;
                    if (M.Appearance.m3colors.hasOwnProperty(m3Key)) {
                        M.Appearance.m3colors[m3Key] = json[key];
                    }
                }
            }
            M.Appearance.m3colors.darkmode = (M.Appearance.m3colors.m3windowBackground.hslLightness < 0.5);
            console.log("[ThemeEngine] applied theme colors");
        } catch (e) {
            console.log("[ThemeEngine] failed to parse theme.json: " + e);
        }
    }

    FileView {
        id: themeFileView
        path: Qt.resolvedUrl(root.filePath)
        watchChanges: true
        onLoadedChanged: { root.applyColors(themeFileView.text()); }
        onLoadFailed: { console.log("[ThemeEngine] theme.json not found — using fallback colors"); }
    }
}
