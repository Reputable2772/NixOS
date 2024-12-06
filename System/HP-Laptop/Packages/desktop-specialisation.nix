{ config, lib, ... }:
let
  prefer-gnome = true;
  prefer-kde = !prefer-gnome;
  cfg = config.specialisation.desktop-environment.configuration;
in
/**
  Works with the following logic.

  If Hyprland is enabled (on main), enable KDE in specialisation.
  If GNOME/KDE is enabled, enable Hyprland in specialisation.

  These values must be mkForce'd to avoid issues with pulling in default configs.
*/
{
  specialisation.desktop-environment.configuration = {
    programs.hyprland.enable = lib.mkForce false;

    # Enable when either GNOME/KDE is enabled.
    services.xserver.enable = lib.mkForce (
      cfg.services.desktopManager.plasma6.enable || cfg.services.xserver.desktopManager.gnome.enable
    );

    services.desktopManager.plasma6.enable = lib.mkForce (
      config.programs.hyprland.enable && prefer-kde
    );
    services.displayManager.sddm = lib.mkForce {
      enable = cfg.services.desktopManager.plasma6.enable;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
      autoNumlock = true;
    };

    services.xserver.desktopManager.gnome.enable = lib.mkForce (
      config.programs.hyprland.enable && prefer-gnome
    );

    services.xserver.displayManager.gdm.enable = lib.mkForce cfg.services.xserver.desktopManager.gnome.enable;
  };
}
