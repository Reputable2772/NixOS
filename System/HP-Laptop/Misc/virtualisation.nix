{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      package = pkgs.podman;
      dockerCompat = true;
      # dockerSocket.enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
        ipv6 = true;
      };
    };
    containers.enable = true;
    oci-containers.backend = "podman";
  };
}
