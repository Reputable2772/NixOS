{ config, pkgs, ... }:
let
  beeper-desktop = pkgs.callPackage ../../../../Packages/beeper.nix { };
in
{
  home.packages = with pkgs; [ beeper-desktop ];

  xdg.configFile."autostart/beeper.desktop".text = ''
    [Desktop Entry]
    Name=Beeper
    Exec=beeper --no-sandbox %U
    Terminal=false
    Type=Application
    Icon=beeper
    StartupWMClass=Beeper
    X-AppImage-Version=latest
    Comment=Beeper: Unified Messenger
    Categories=Utility;
  '';
}
