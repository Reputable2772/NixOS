{
  programs.quadlets.quadlets = [
    {
      name = "caddy.network";
      content = ''
        [Network]
        DNS=192.168.0.102
        Driver=bridge
        Gateway=10.89.0.1
        Gateway=fdd6:61c:2978:8345::1
        IPAMDriver=host-local
        IPv6=true
        PodmanArgs=--interface-name podman1
        Subnet=10.89.0.0/24
        Subnet=fdd6:61c:2978:8345::/64
      '';
    }
  ];
}
