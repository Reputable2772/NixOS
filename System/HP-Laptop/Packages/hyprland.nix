{
  imports = [
    ../../../Modules/System/hyprland.nix
    ../../../Modules/System/gnome.nix
  ];

  programs.gnome.enable = false;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
