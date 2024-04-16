{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.hyprland;
in
{
  options.programs.hyprland = { };

  config = mkIf cfg.enable {
    xdg.portal = {
      inherit (cfg) enable;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };

    environment.systemPackages = [ pkgs.xdg-utils ];

    # Thunar
    programs.thunar = {
      inherit (cfg) enable;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    programs.xfconf.enable = cfg.enable;
    services.gvfs.enable = cfg.enable;

    # Removable Media
    services.tumbler.enable = cfg.enable;
    services.devmon.enable = cfg.enable;
    services.udisks2.enable = cfg.enable;

    # Power Profiles Daemon
    services.power-profiles-daemon.enable = cfg.enable;
    services.upower.enable = cfg.enable;
  };
}
