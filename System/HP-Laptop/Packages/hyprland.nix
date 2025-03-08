{
  # TODO: Wrap Hyprland package with UWSM so that the command 'Hyprland' starts uwsm first.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
}
