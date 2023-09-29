{
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedTCPPorts = [ 8384 22000 443 80 ]; # Syncthing, Caddy
    allowedUDPPorts = [ 22000 21027 ]; # Syncthing
  };
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # hardware.enableAllFirmware = true;
  # nixpkgs.config.allowUnfree = true;

}
