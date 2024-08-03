{
  programs.quadlets.quadlets."caddy.network" = {
    Network = {
      Driver = "bridge";
      Gateway = [
        "10.89.0.1"
        "fdd6:61c:2978:8345::1"
      ];
      IPAMDriver = "host-local";
      IPv6 = true;
      PodmanArgs = "--interface-name podman1";
      Subnet = [ "10.89.0.0/24" "fdd6:61c:2978:8345::/64" ];
    };
  };
}
