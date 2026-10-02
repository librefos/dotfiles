/* user.js - Firefox declarative user preferences.
   Copyright (C) 2026 Thiago C. Silva

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>. */

// --- Enable Custom CSS ---
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// --- UI Friction Reduction ---
user_pref("browser.aboutConfig.showWarning", false);

// --- Tabs & Sidebar ---
// The horizontal strip; chrome/userChrome.css moves it to the bottom
// and is written against this being false.
user_pref("sidebar.verticalTabs", false);
// hide-sidebar, so the launcher strip of tool icons is not down the
// side of every window; the sidebar button in the nav bar still opens
// it.  The other values are always-show and expand-on-hover, which was
// what left the strip there.
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("sidebar.expandOnHover", false);

// --- Linux Integration ---
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);

// --- Hardware Acceleration (Vega 8 / VA-API) ---
user_pref("media.ffmpeg.vaapi.enabled", true);

// --- Dark Theme Enforcement ---
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.in-content.dark-mode", true);
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);
