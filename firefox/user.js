user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("ui.key.menuAccessKeyFocuses", false);
/* Accelerated canvas */
user_pref("gfx.canvas.accelerated", true);
/* WebRender enable */
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.enable-capture", true);
user_pref("gfx.webrender.compositor.force-enabled", true);
/* Accelerated Compositing Layers */
user_pref("layers.acceleration.force-enabled", true);
/* VAAPI */
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffvpx.enabled", false);
user_pref("media.navigator.mediadatadecoder_vpx_enabled", true);
/* For userChrome.css */
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
/* Hide annoying WebRTC indicator */
user_pref("privacy.webrtc.legacyGlobalIndicator", false);
user_pref("privacy.webrtc.hideGlobalIndicator", true);
/* Automatically close cookie banners */
user_pref("cookiebanners.service.mode", 2);
user_pref("cookiebanners.service.mode.privateBrowsing", 2);

/* Workaround for https://bugzilla.mozilla.org/show_bug.cgi?id=1619585 */
/*user_pref("security.sandbox.content.level", 0);
user_pref("media.rdd-process.enabled", false);
user_pref("media.rdd-ffvpx.enabled", false);
user_pref("media.rdd-vpx.enabled", false);*/
