{
  networking.firewall = {
    enable = true;
    interfaces.eno1.allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    interfaces.eno1.allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    interfaces.eno1.allowedTCPPorts = [ 8384 22000 443 80 ]; # Syncthing, Caddy
    interfaces.eno1.allowedUDPPorts = [ 22000 21027 443 80 ]; # Syncthing
    logRefusedPackets = true;

    interfaces.wlo1.allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    interfaces.wlo1.allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    interfaces.wlo1.allowedTCPPorts = [ 8384 22000 443 80 ]; # Syncthing, Caddy
    interfaces.wlo1.allowedUDPPorts = [ 22000 21027 443 80 ]; # Syncthing
  };
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
}