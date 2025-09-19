{ config, lib, ... }:
{
  networking = {
    firewall = {
      enable = true;
      logRefusedPackets = true;
    };

    nameservers = [
      "127.0.0.1"
      "1.1.1.1"
    ];
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  environment.etc."resolv.conf".text = lib.concatMapStringsSep "\n" (
    x: "nameserver ${x}"
  ) config.networking.nameservers;

  services.dnscrypt-proxy = {
    enable = true;
    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "cloudflare"
        "cloudflare-ipv6"
        "quad9-dnscrypt-ip4-filter-ecs-pri"
        "quad9-dnscrypt-ip6-filter-ecs-pri"
      ];
    };
  };
}
