{
  osConfig,
  pkgs,
  lib,
  ...
}:
let
  cond = osConfig.services.desktopManager.gnome.enable;
in
{
  stylix.targets.gnome.enable = cond;

  # Required even if Gnome is not installed
  home.packages =
    with pkgs;
    [
      dconf2nix
      dconf-editor
    ]
    ++ lib.optionals cond (
      with pkgs.gnomeExtensions;
      [
        appindicator
        caffeine

        # Can stay non-declarative, since all bluetooth devices configuration is non-declarative anyway.
        bluetooth-battery
        # Can be used once oae/gnome-shell-pano#271 is closed.
        pano
      ]
    );

  dconf.settings = {
    "org/gnome/shell" = {
      disabled-extensions = [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "just-perfection-desktop@just-perfection"
        "Vitals@CoreCoding.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "bluetooth-battery@michalw.github.com"
        "caffeine@patapon.info"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "pano@elhan.io"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "librewolf.desktop"
        "firefox.desktop"
        "org.codeberg.dnkl.foot.desktop"
        "@joplinapp-desktop.desktop"
      ];
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 3;
    };

    "org/gnome/shell/extensions/system-monitor" = {
      show-swap = false;
    };
  };

  # Fixes NixOS/nixpkgs#53631
  home.sessionVariables = lib.optionalAttrs cond {
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (
      with pkgs.gst_all_1;
      [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]
    );
  };
}
