{ lib, ... }:
{
  specialisation.gnome.configuration = {
    services.xserver.enable = lib.mkForce true;
    services.xserver.desktopManager.gnome.enable = lib.mkForce true;
  };
}
