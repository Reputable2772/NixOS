{ pkgs, ... }:
{
  # NixOS/nixpkgs#455529
  home.packages = with pkgs; [
    kdePackages.xwaylandvideobridge
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class ^(xwaylandvideobridge)$, opacity 0.0 override 0.0 override"
    "match:class ^(xwaylandvideobridge)$, anim off"
    "match:class ^(xwaylandvideobridge)$, initial_focus off"
    "match:class ^(xwaylandvideobridge)$, max_size 1 1"
    "match:class ^(xwaylandvideobridge)$, blur off"
  ];
}
