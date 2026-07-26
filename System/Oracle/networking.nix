{ config, ... }: {
  networking.hostName = "oracle-server";
  networking.firewall = config.hm-config.firewall;
}
