{ pkgs, ... }:
{
  # NixOS/nixpkgs#455529
  home.packages = with pkgs; [
    kdePackages.xwaylandvideobridge
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    {
      match = {
        class = "^(xwaylandvideobridge)$";
      };
      opacity = "0.0 override 0.0 override";
      anim = false;
      initial_focus = false;
      max_size = "1 1";
      blur = false;
    }
  ];
}
