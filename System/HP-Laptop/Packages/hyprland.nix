{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs; [ xdg-utils ];
}