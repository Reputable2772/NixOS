{ lib, osConfig, ... }:
{
  imports =
    [
      ./gnome.nix
      ./stub.nix
    ]
    # Unfortunately, this conditional import has to remain since we cannot modify either files.
    ++ lib.optional osConfig.services.desktopManager.gnome.enable ./settings.nix
    ++ lib.optional (!osConfig.services.desktopManager.gnome.enable) ./dconf.nix;
}
