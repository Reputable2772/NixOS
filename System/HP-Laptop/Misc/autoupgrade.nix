{ config, lib, ... }: {
  system.autoUpgrade = {
    enable = true;
    flake = "\"$(readlink -f /etc/nixos)\"";
    flags = [
      "-L"
    ];
    dates = "daily";
  };

  # We don't need the upgrade flag due to the CI doing it for us. https://github.com/NixOS/nixpkgs/blob/2230a20f2b5a14f2db3d7f13a2dc3c22517e790b/nixos/modules/tasks/auto-upgrade.nix#L255
  systemd.services.nixos-upgrade.script = lib.mkForce "${config.system.build.nixos-rebuild}/bin/nixos-rebuild ${config.system.autoUpgrade.operation} ${builtins.toString config.system.autoUpgrade.flags}";
}
