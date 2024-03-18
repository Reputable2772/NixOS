{ lib, osConfig, ... }:
{
  imports = [
    ../../../../../Modules/Home-Manager/gnome.nix
    ./gnome.nix
  ]
  ++ lib.optional osConfig.services.xserver.desktopManager.gnome.enable ./settings.nix
  ++ lib.optional (!osConfig.services.xserver.desktopManager.gnome.enable) ./dconf.nix;
}
