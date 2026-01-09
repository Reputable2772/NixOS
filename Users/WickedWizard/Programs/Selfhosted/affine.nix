{ pkgs, ... }:
{
  home.packages = with pkgs; [ affine-bin ];
  programs.autostart.packages = with pkgs; [ affine-bin ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:initial_class (AFFiNE), workspace 2"
  ];
  system-config.nixpkgs.config.permittedInsecurePackages = [ "electron-35.7.5" ];
}
