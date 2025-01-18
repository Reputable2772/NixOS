{ lib, ... }:
{
  networking = {
    hostName = "hp-laptop";
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedTCPPorts =
        [ 53 ] # DNS
        ++ [
          80
          443
        ] # Caddy
        ++ [ 22000 ]; # Syncthing
      # ++ [ 61851 ]; # qBittorrent
      allowedUDPPorts =
        [
          80
          443
        ] # Caddy
        ++ [
          22000
          21027
        ]; # Syncthing
      # ++ [ 61851 ]; # qBittorrent
    };
    networkmanager.connectionConfig = {
      "wifi.powersave" = lib.mkForce 2;
    };
  };
}
