/* user.js - Firefox Developer Edition declarative user preferences.
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

// --- Profile & UI ---
user_pref("browser.aboutConfig.showWarning", false);
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.in-content.dark-mode", true);
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);
user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
user_pref("browser.theme.native-theme", true);
user_pref("layout.css.prefers-color-scheme.content-override", 0);
user_pref("browser.uidensity", 1);
user_pref("browser.uiCustomization.state", "{\"placements\":{\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"spring\",\"vertical-spacer\",\"urlbar-container\",\"spring\",\"downloads-button\",\"open-file-button\",\"profiler-button\",\"panic-button\",\"library-button\",\"preferences-button\",\"developer-button\"]},\"seen\":[\"developer-button\",\"library-button\",\"open-file-button\",\"panic-button\",\"preferences-button\",\"profiler-button\"],\"dirtyAreaCache\":[\"nav-bar\"],\"currentVersion\":24,\"newElementCount\":0}");
user_pref("browser.toolbars.bookmarks.visibility", "never");

// --- Home & Startup ---
user_pref("browser.startup.page", 0);
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.startup.homepage.abouthome_cache.enabled", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// --- Search & Address Bar ---
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.suggest.enabled.private", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.recentsearches", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.quickactions", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.remotetab", false);
user_pref("browser.urlbar.suggest.calculator", false);
user_pref("browser.urlbar.suggest.weather", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.urlbar.suggest.quicksuggest.all", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.quicksuggest.online.enabled", false);
user_pref("browser.urlbar.quicksuggest.mlEnabled", false);
user_pref("browser.urlbar.suggest.addons", false);
user_pref("browser.urlbar.suggest.mdn", false);
user_pref("browser.urlbar.suggest.yelp", false);
user_pref("browser.urlbar.suggest.amp", false);
user_pref("browser.urlbar.suggest.wikipedia", false);
user_pref("browser.urlbar.wikipedia.featureGate", false);
user_pref("browser.urlbar.suggest.sports", false);
user_pref("browser.urlbar.showSearchTerms.enabled", false);
user_pref("browser.urlbar.showSearchTerms.featureGate", false);

// --- Privacy & Security ---
user_pref("browser.contentblocking.category", "strict");
user_pref("browser.contentblocking.features.strict", "tp,tpPrivate,cookieBehavior5,cookieBehaviorPBM5,cryptoTP,fp,stp,emailTP,emailTPPrivate,-consentmanagerSkip,-consentmanagerSkipPrivate,lvl2,rp,rpTop,qps,qpsPBM,fpp,fppPrivate,btp,lna");
user_pref("network.cookie.cookieBehavior", 5);
user_pref("network.cookie.cookieBehavior.pbmode", 5);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.globalprivacycontrol.pbmode.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("places.history.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", false);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.sessions", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.siteSettings", true);
user_pref("privacy.clearOnShutdown.openWindows", false);
user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", true);
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);
user_pref("privacy.clearOnShutdown_v2.cache", true);
user_pref("privacy.clearOnShutdown_v2.siteSettings", true);
user_pref("privacy.clearOnShutdown_v2.formdata", false);
user_pref("privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs2", true);
user_pref("privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3", true);
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.trr.custom_uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.trr_ui.fallback_was_checked", true);
user_pref("doh-rollout.mode", 3);
user_pref("doh-rollout.disable-heuristics", true);
user_pref("doh-rollout.clearModeOnShutdown", false);
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_pbm", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);
user_pref("dom.security.https_only_mode_ever_enabled_pbm", true);

// --- Passwords & Autofill ---
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.addresses.capture.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

// --- Downloads ---
user_pref("browser.download.folderList", 2);
user_pref("browser.download.dir", "/tmp");
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.download.always_ask_before_handling_new_types", true);
user_pref("browser.download.enableDeletePrivate", true);
user_pref("browser.download.deletePrivate", true);
user_pref("browser.download.deletePrivate.chosen", true);

// --- Linux Integration ---
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.eme.enabled", true);

// --- Tabs & Browsing ---
user_pref("sidebar.verticalTabs", false);
// hide-sidebar, so the launcher strip of tool icons is not down the
// side of every window; the sidebar button in the nav bar still opens
// it.  The other values are always-show and expand-on-hover, which was
// what left the strip there.
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("sidebar.expandOnHover", false);
user_pref("sidebar.revamp", true);
user_pref("sidebar.main.tools", "syncedtabs,history");
user_pref("browser.ctrlTab.sortByRecentlyUsed", false);
user_pref("browser.tabs.hoverPreview.enabled", false);
user_pref("browser.tabs.hoverPreview.showThumbnails", false);
user_pref("browser.tabs.groups.hoverPreview.enabled", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.tabs.groups.smart.userEnabled", false);
user_pref("browser.tabs.groups.smart.optin", false);
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.ml.linkPreview.optin", false);
user_pref("media.videocontrols.picture-in-picture.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
user_pref("media.videocontrols.picture-in-picture.urlbar-button.enabled", false);

// --- Recommendations, Language & AI ---
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.discovery.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.translations.enable", false);
user_pref("browser.translations.select.enable", false);
user_pref("browser.translations.quickAction.enabled", false);
user_pref("browser.translations.automaticallyPopup", false);
user_pref("intl.accept_languages", "en");
user_pref("intl.locale.requested", "en");
user_pref("layout.spellcheckDefault", 0);
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ai.control.translations", "blocked");
user_pref("browser.ai.control.smartTabGroups", "blocked");
user_pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
user_pref("browser.ai.control.sidebarChatbot", "blocked");
user_pref("browser.ai.control.smartWindow", "blocked");

// --- Permissions ---
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.microphone", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.xr", 2);
user_pref("permissions.default.local-network", 2);
user_pref("permissions.default.loopback-network", 2);
user_pref("network.lna.blocking", true);
user_pref("media.setsinkid.enabled", false);

// --- Developer Tools ---
user_pref("devtools.theme", "dark");
user_pref("devtools.toolbox.host", "right");
user_pref("devtools.cache.disabled", true);
user_pref("devtools.inspector.showUserAgentStyles", true);
user_pref("devtools.performance.popup.feature-flag", true);
user_pref("devtools.command-button-frames.enabled", true);
user_pref("devtools.command-button-responsive.enabled", true);
user_pref("devtools.command-button-screenshot.enabled", true);
user_pref("devtools.command-button-rulers.enabled", true);
user_pref("devtools.command-button-measure.enabled", true);
user_pref("devtools.command-button-noautohide.enabled", true);
user_pref("devtools.command-button-paintflashing.enabled", true);
user_pref("devtools.webconsole.persistlog", true);
user_pref("devtools.netmonitor.persistlog", true);
user_pref("devtools.webconsole.timestampMessages", true);

// Browser Toolbox / Browser Console support. Keep the connection prompt on.
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.debugger.prompt-connection", true);
