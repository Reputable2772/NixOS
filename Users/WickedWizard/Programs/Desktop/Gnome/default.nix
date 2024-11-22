{ lib, osConfig, ... }:
{
  imports =
    [
      ./gnome.nix
    ]
    # Unfortunately, this conditional import has to remain since we cannot modify either files.
    ++ lib.optional osConfig.services.xserver.desktopManager.gnome.enable ./settings.nix
    ++ lib.optional (!osConfig.services.xserver.desktopManager.gnome.enable) ./dconf.nix;
}
