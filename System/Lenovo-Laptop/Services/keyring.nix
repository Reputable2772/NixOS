{ config, ... }:
{
  services.gnome.gnome-keyring.enable = true;

  home-manager.sharedModules = [
    { services.gnome-keyring.enable = config.services.gnome.gnome-keyring.enable; }
  ];
}
