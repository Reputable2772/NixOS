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
    containers = {
      enable = true;
      registries.settings = {
        registry = [
          {
            location = "docker.io";
          }
          {
            location = "quay.io";
          }
        ];
        unqualified-search-registries = [ "docker.io" ];
      };
    };
    oci-containers.backend = "podman";
  };
}
