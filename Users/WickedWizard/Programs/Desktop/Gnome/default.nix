{ lib, osConfig, ... }:
{
  imports = [
    ./gnome.nix
  ]
  ++ lib.optional osConfig.services.xserver.desktopManager.gnome.enable ./settings.nix
  ++ lib.optional (!osConfig.services.xserver.desktopManager.gnome.enable) ./dconf.nix;
}
