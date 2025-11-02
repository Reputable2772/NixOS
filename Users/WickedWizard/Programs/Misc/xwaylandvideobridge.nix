{ pkgs, ... }:
{
  # NixOS/nixpkgs#455529
  home.packages = with pkgs; [
    kdePackages.xwaylandvideobridge
  ];

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
    "noanim,class:^(xwaylandvideobridge)$"
    "noinitialfocus,class:^(xwaylandvideobridge)$"
    "maxsize 1 1,class:^(xwaylandvideobridge)$"
    "noblur,class:^(xwaylandvideobridge)$"
  ];
}
