{
  imports = [
    ../../../Modules/System/hyprland.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
