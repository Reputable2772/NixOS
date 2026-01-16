{ config, lib, ... }:
{
  # Don't wait for online.
  systemd.services.NetworkManager-wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  networking = {
    firewall = config.hm-config.firewall // {
      enable = true;
      extraCommands = ''
        # Delete the accept rule for nixos-fw-accept
        ip6tables -D nixos-fw-accept -j ACCEPT

        # Delete critical rules that redirect to nixos-fw-accept
        ip6tables -D nixos-fw -i lo -j nixos-fw-accept
        ip6tables -D nixos-fw -m conntrack --ctstate RELATED,ESTABLISHED -j nixos-fw-accept
        ip6tables -D nixos-fw -p ipv6-icmp -j nixos-fw-accept
        ip6tables -D nixos-fw -d fe80::/64 -p udp --dport 546 -j nixos-fw-accept
        ip6tables -D nixos-fw -i podman0 -p udp --dport 53 -j nixos-fw-accept

        # Add the critical rules back, with ACCEPT
        ip6tables -A nixos-fw -i lo -j ACCEPT
        ip6tables -A nixos-fw -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
        ip6tables -A nixos-fw -p ipv6-icmp -j ACCEPT
        ip6tables -A nixos-fw -d fe80::/64 -p udp --dport 546 -j ACCEPT
        ip6tables -A nixos-fw -i podman0 -p udp --dport 53 -j ACCEPT

        # Set DROP rule for nixos-fw-accept
        ip6tables -A nixos-fw-accept -j nixos-fw-log-refuse
      '';
    };
    hostName = "lenovo-laptop";
    networkmanager.connectionConfig = {
      "wifi.powersave" = lib.mkForce 3;
    };
  };
}
