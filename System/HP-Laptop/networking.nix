{
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedTCPPorts =
      [ 53 ] # DNS
      ++ [ 80 443 ] # Caddy
      ++ [ 22000 ] # Syncthing
      ++ [ 61851 ]; # qBittorrent
    allowedUDPPorts =
      [ 80 443 ] # Caddy
      ++ [ 22000 21027 ] # Syncthing
      ++ [ 61851 ]; # qBittorrent
    logRefusedPackets = true;
  };

  networking.hostName = "hp-laptop";
  networking.networkmanager.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    extraConfig = ''
      DNSOverTLS=true
      MulticastDNS=resolve
      DNSStubListenerExtra=0.0.0.0
    '';
    llmnr = "true";
  };

  networking.nameservers = [
    "1.1.1.1#cloudflare-dns.com"
    "1.0.0.1#cloudflare-dns.com"
    "2606:4700:4700::1111#cloudflare-dns.com"
    "2606:4700:4700::1001#cloudflare-dns.com"
  ];
}
