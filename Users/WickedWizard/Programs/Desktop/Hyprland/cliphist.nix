{ config, pkgs, lib, ... }:
let
  hyprland = config.wayland.windowManager.hyprland;
in
{
  home.packages = lib.mkIf (hyprland.enable) (with pkgs; [
    wl-clipboard
    cliphist
  ]);

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
      "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
    ];
    bind = [
      "rofi -modi clipboard:${config.xdg.configHome}/cliphist/scripts/rofi-img.sh -show clipboard -show-icons"
    ];
  };

  xdg.configFile.cliphist = {
    enable = true;
    target = "cliphist/scripts/rofi-img.sh";
    executable = true;
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/sentriz/cliphist/master/contrib/cliphist-rofi-img";
      hash = "";
    };
  };
}
