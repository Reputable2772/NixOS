{ config, lib, pkgs, options, polyfill, ... }:
let
  cfg = config.programs.hyprland;
  inherit (lib.attrsets) filterAttrs mapAttrs;
  inherit (lib.modules) mkMerge mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.programs.hyprland = {
    autostart = mkEnableOption "Autostart Desktop Apps in ~/.config/autostart. Requires HM.";
  };

  imports = [ ] ++ lib.optional polyfill {
    options.home-manager = lib.mkSinkUndeclaredOptions { };
  };

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

      environment.systemPackages = [ pkgs.xdg-utils ];

      # Thunar
      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
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

    (mkIf (cfg.enable && (config ? home-manager)) {
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
    })
  ];
}
