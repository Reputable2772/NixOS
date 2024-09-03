{ lib, ... }: {
  services.xserver.desktopManager.gnome.enable = true;

  hardware.pulseaudio.enable = lib.mkForce false;
  services.openssh.enable = lib.mkForce false;
  services.avahi.enable = lib.mkForce false;

  # Disable unnecessary gnome services.
  services.gnome.at-spi2-core.enable = lib.mkForce false;
  services.gnome.evolution-data-server.enable = lib.mkForce false;
  services.gnome.gnome-online-accounts.enable = lib.mkForce false;
  services.gnome.tracker-miners.enable = lib.mkForce false;
  services.gnome.tracker.enable = lib.mkForce false;
}
