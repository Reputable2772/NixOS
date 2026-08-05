{ config, ... }: {
  networking.hostName = "oracle-server";
  networking.firewall = config.hm-config.firewall;

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
}
