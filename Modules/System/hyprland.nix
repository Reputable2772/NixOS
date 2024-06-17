{ config, lib, pkgs, ... }:
# with lib;
let
  cfg = config.programs.hyprland;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in
{
  options.programs.hyprland = {
    hyprlock.pam.enable = mkEnableOption "Hyprlock PAM";
  };

  config = mkIf cfg.enable {
    # Fixes https://github.com/NixOS/nixpkgs/issues/189851#issuecomment-1238907955
    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"
    '';

    xdg.portal = {
      inherit (cfg) enable;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };

    environment.systemPackages = [ pkgs.xdg-utils ];

    security.pam.services.hyprlock = mkIf cfg.hyprlock.pam.enable { };

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
