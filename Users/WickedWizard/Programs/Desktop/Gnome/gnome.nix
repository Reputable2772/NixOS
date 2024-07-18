{ osConfig, pkgs, lib, ... }:
let
  cond = osConfig.services.xserver.desktopManager.gnome.enable;
in
{
  # Required even if Gnome is not installed
  home.packages =
    with pkgs; [
      dconf2nix
      gnome-terminal
      dconf-editor
    ] ++ lib.optionals cond (with pkgs.gnomeExtensions; [
      appindicator
      bluetooth-battery
      caffeine
      just-perfection
      pano
      rounded-window-corners
      vitals
    ]);

  # Fixes NixOS/nixpkgs#53631
  home.sessionVariables = lib.optionalAttrs cond {
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      (with pkgs.gst_all_1; [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]);
  };
}
