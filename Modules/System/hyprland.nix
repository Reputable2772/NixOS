{ config, lib, pkgs, ... }:
let
  cfg = config.programs.hyprland;
  inherit (lib.modules) mkMerge mkIf;
in
{
  options.programs.hyprland = { };

  config = mkMerge [
    (mkIf cfg.enable {
      /**
        Does not prioritize /run/wrappers/bin, causes further issues with
        systemd's user config.

        https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/hyprland.nix#L63-L68
      */
      programs.hyprland.systemd.setPath.enable = false;

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        xdgOpenUsePortal = true;
      };

      programs.xfconf.enable = true;
      services.gvfs.enable = true;

      # Removable Media
      services.tumbler.enable = true;
      services.devmon.enable = true;
      services.udisks2.enable = true;

      # Power Profiles Daemon
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;
    })
  ];
}
