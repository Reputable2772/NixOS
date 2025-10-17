{ pkgs, ... }:
{
  home.packages = with pkgs; [ affine-bin ];
  programs.autostart.packages = with pkgs; [ affine-bin ];

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "workspace 2, initialClass:(AFFiNE)"
  ];
  system-config.nixpkgs.config.permittedInsecurePackages = [ "electron-35.7.5" ];
}
