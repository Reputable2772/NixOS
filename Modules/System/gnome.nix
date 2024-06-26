{ config, lib, ... }:
with lib;
let
  cfg = config.services.xserver.desktopManager.gnome;
in
{
  options.services.xserver.desktopManager.gnome = {
    avahi.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable Avahi Daemon
      '';
    };
    ssh.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable SSH Daemon
      '';
    };
    excludePackages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.totem ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Which packages gnome should exclude from the default environment";
    };
  };

  config = {
    environment.gnome.excludePackages = cfg.excludePackages;

    services.avahi.enable = cfg.avahi.enable;
    services.openssh.enable = cfg.ssh.enable;
  };
}
