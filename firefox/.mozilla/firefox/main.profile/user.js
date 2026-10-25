// --- UI Friction Reduction ---
user_pref("browser.aboutConfig.showWarning", false);

// --- Tabs & Sidebar ---
user_pref("sidebar.verticalTabs", false);
// hide-sidebar, so the launcher strip of tool icons is not down the
// side of every window; the sidebar button in the nav bar still opens
// it.  The other values are always-show and expand-on-hover, which was
// what left the strip there.
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("sidebar.expandOnHover", false);

// --- Hardware Acceleration (Vega 8 / VA-API) ---
user_pref("media.ffmpeg.vaapi.enabled", true);

// --- Dark Theme Enforcement ---
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.in-content.dark-mode", true);
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);
user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
user_pref("browser.theme.native-theme", true);
