{ pkgs, ... }: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      # dockerSocket.enable = true;
      defaultNetwork.settings = { dns_enabled = true; ipv6 = true; };
    };
    containers.enable = true;
    containers.storage.settings = {
      storage = {
        driver = "overlay";
        runroot = "/run/containers/storage";
        graphroot = "/var/lib/containers/storage";
        rootless_storage_path = "/tmp/containers-$USER";
        options.overlay.mountopt = "nodev,metacopy=on";
      };
    };

    oci-containers.backend = "podman";
    waydroid.enable = true;
  };

  # Fixes https://matrix.to/#/!RRerllqmbATpmbJgCn:nixos.org/$BYFRKRjy_uQ8LfOdzx_qxaHXSeATi6ZsJf8Rcy87Wjs?via=nixos.org&via=matrix.org&via=tchncs.de
  environment.etc.quadlet-user-generator = {
    source = "${pkgs.podman}/lib/systemd/user-generators/podman-user-generator";
    target = "/etc/systemd/user-generators/podman-user-generators";
  };
}
