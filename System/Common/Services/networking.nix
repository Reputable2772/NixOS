{ pkgs, ... }:
{
  networking = {
    firewall = {
      enable = true;
      logRefusedPackets = true;
    };

    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  environment.systemPackages = [
    (pkgs.writeScriptBin "stubby-hash-generator" "echo | ${pkgs.openssl}/bin/openssl s_client -connect $1 2>/dev/null | ${pkgs.openssl}/bin/openssl x509 -pubkey -noout | ${pkgs.openssl}/bin/openssl pkey -pubin -outform der | ${pkgs.openssl}/bin/openssl dgst -sha256 -binary | ${pkgs.openssl}/bin/openssl enc -base64")
  ];

  services.dnscrypt-proxy2 = {
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
