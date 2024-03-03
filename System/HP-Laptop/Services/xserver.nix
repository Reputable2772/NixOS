{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager.gnome.enable = false;
    displayManager.gdm.enable = true;
    excludePackages = with pkgs; [ xterm ];
  };
}
