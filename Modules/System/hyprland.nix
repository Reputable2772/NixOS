{ config, lib, pkgs, options, ... }:
let
  cfg = config.programs.hyprland;
  inherit (lib.attrsets) filterAttrs mapAttrs;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.programs.hyprland = {
    hyprlock.pam.enable = mkEnableOption "Hyprlock PAM";

    autostart = mkEnableOption "Autostart Desktop Apps in ~/.config/autostart" // { default = true; };
  };

  config = mkIf cfg.enable {
    /**
      Does not prioritize /run/wrappers/bin, causes further issues with
      systemd's user config.

      https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/hyprland.nix#L63-L68
     */
    programs.hyprland.systemd.setPath.enable = false;

    # Fixes NixOS/nixpkgs#189851
    home-manager.users = mapAttrs
      (n: v: {
        wayland.windowManager.hyprland.systemd = {
          enable = lib.mkDefault true;
          variables =
            # Append to default options provided by HM.
            (options.home-manager.users.type.getSubOptions [ ]).wayland.windowManager.hyprland.systemd.variables.default
            ++ [ "PATH" ];
          extraCommands =
            (options.home-manager.users.type.getSubOptions [ ]).wayland.windowManager.hyprland.systemd.extraCommands.default
            ++ [ "systemctl --user stop xdg-desktop-portal.service" "systemctl --user start xdg-desktop-portal.service" ]
            ++ lib.lists.optionals cfg.autostart [ "${lib.getExe pkgs.dex} --autostart" ];
        };
      })
      (filterAttrs (n: v: v.isNormalUser) config.users.users);

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
