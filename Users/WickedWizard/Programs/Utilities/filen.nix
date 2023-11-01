{ config, pkgs, ... }:
let filen = pkgs.callPackage ../../../../Packages/filen.nix { };
in {
  home.packages = with pkgs; [ filen ];

  xdg.configFile."autostart/filen.desktop".text = ''
    [Desktop Entry]
    Name=Filen
    Exec=filen-latest %U
    Terminal=false
    Type=Application
    Icon=filen
    StartupWMClass=Filen
    X-AppImage-Version=latest
    Categories=Utility;
  '';
}
