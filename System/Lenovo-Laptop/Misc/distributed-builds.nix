{ config, ... }: {
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  secretspec.config.profiles.lenovo-laptop.REMOTE_BUILDER_AARCH64.description =
    "aarch64-linux remote bulider ssh alias";

  # /root/.ssh has been added to impermanence, for known_hosts and other files.
  systemd.tmpfiles.rules = [
    "L+ /root/.ssh/config - - - - ${config.secretspec.secrets.profiles.lenovo-laptop.REMOTE_BUILDER_AARCH64.plainPath}"
  ];

  nix.buildMachines = [
    {
      # Managed in /root/.ssh/config
      hostName = "remotebuilder";
      sshUser = "remotebuild";
      sshKey = "/etc/ssh/RemoteBuilder";
      system = "aarch64-linux";
      supportedFeatures = [
        "nixos-test"
        "big-parallel"
        "kvm"
      ];
    }
  ];
}
