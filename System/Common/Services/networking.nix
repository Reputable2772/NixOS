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

  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      tls_min_version = "GETDNS_TLS1_3";
      dnssec = "GETDNS_EXTENSION_TRUE";
      upstream_recursive_servers = [
        {
          address_data = "1.1.1.1";
          tls_auth_name = "cloudflare-dns.com";
        }
        {
          address_data = "1.0.0.1";
          tls_auth_name = "cloudflare-dns.com";
        }
        {
          address_data = "2606:4700:4700::1111";
          tls_auth_name = "cloudflare-dns.com";
        }
        {
          address_data = "2606:4700:4700::1001";
          tls_auth_name = "cloudflare-dns.com";
        }
        {
          address_data = "9.9.9.9";
          tls_auth_name = "dns.quad9.net";
        }
        {
          address_data = "149.112.112.112";
          tls_auth_name = "dns.quad9.net";
        }
        {
          address_data = "2620:fe::fe";
          tls_auth_name = "dns.quad9.net";
        }
        {
          address_data = "2620:fe::9";
          tls_auth_name = "dns.quad9.net";
        }
      ];
    };
  };
}
