{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    excludePackages = with pkgs; [ xterm ];
  };
}
