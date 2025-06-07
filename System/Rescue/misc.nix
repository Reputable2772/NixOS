{ lib, ... }:
{
  services.desktopManager.gnome.enable = true;

  services.openssh.enable = lib.mkForce false;
  services.avahi.enable = lib.mkForce false;

  # Disable unnecessary gnome services.
  services.gnome.at-spi2-core.enable = lib.mkForce false;
  services.gnome.evolution-data-server.enable = lib.mkForce false;
  services.gnome.gnome-online-accounts.enable = lib.mkForce false;
  services.gnome.localsearch.enable = lib.mkForce false;
  services.gnome.tinysparql.enable = lib.mkForce false;
}
