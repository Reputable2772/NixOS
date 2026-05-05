{ lib, ... }:
{
  services.xserver.enable = lib.mkDefault false;
  services.desktopManager.cosmic.enable = false;
  services.displayManager.cosmic-greeter.enable = false;
}
