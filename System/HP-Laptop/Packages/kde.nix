{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = false;
  services.displayManager.sddm = {
    enable = false;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
  };
}
