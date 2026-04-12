{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persist" = {
    enable = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"

      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
      "/var/lib/sbctl"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
