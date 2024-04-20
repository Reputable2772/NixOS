{
  networking = {
    firewall = {
      enable = true;
      logRefusedPackets = true;
    };

    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
    ];
    networkmanager.enable = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
    llmnr = "true";
    domains = [ "~." ];
    fallbackDns = [
      "8.8.8.8"
      "2001:4860:4860::8844"
    ];
    extraConfig = ''
      DNSOverTLS=true
      MulticastDNS=resolve
      DNSStubListenerExtra=0.0.0.0
    '';
  };
}
