{ config, pkgs, ... }:
let
  fromINI = f:
    let
      iniFile = pkgs.runCommand "convertini"
        {
          nativeBuildInputs = [ pkgs.jc ];
        } ''jc --ini < ${f} > "$out" '';
    in
    builtins.fromJSON (builtins.readFile iniFile);
  file = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/dunst/main/themes/mocha.conf";
    hash = "sha256-7bejAIpueES8pwyiyY0RcMJwaFkTBf1G1RR1EhHqvig=";
  };
in
{
  services.dunst = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = (fromINI file) // { };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "CTRL SUPER, N, exec, dunstctl close-all"
      "SUPER, N, exec, dunstctl history-pop"
      "CTRL SUPER, D, exec, dunstctl set-paused toggle"
    ];
  };
}
