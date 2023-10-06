{ config, pkgs, ... }:
let
  beeper-desktop = pkgs.callPackage ../../../Packages/beeper.nix { };
in
{
  home.packages = with pkgs; [ beeper-desktop ];

  xdg.configFile."autostart/beeper.desktop".source = "${pkgs.beeper}/share/applications/beeper.desktop";
}
