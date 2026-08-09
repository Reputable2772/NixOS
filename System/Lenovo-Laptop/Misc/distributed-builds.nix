{ config, ... }: {
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  systemd.tmpfiles.rules = [
    "L+ /root/.ssh/config - - - - ${config.age.secrets.distributed-builds-ssh-config.path}"
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
