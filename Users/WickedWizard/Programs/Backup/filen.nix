{ config, pkgs, ... }:
let filen = pkgs.callPackage ../../../../Packages/filen.nix { };
in {
  home.packages = with pkgs; [ filen ];

  xdg.configFile."autostart/filen.desktop".text = "${filen}/share/applications/filen.desktop";
}
