{ lib, ... }: {
  services.xserver.enable = lib.mkDefault false;

  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  system.stateVersion = "26.05";
}
