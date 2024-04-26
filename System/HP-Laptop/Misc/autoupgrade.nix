{ config, lib, ... }: {
  system.autoUpgrade = {
    enable = true;
    # This is because I consider the changes I push to Github to be stable enough for usage.
    # Feel free to replace this with something like \"$(readlink -f /etc/nixos)\"
    # Since /etc/nixos is already symlinked to your current config directory.
    # Beware that you have to pull the changes from CI manually if you use the above.
    flake = "github:Reputable2772/NixOS";
    flags = [
      "--print-build-logs"
      "--show-trace"
    ];
    dates = "*-*-* 00:00:00 ${config.time.timeZone}";
  };

  # We don't need the upgrade flag due to the CI doing it for us. https://github.com/NixOS/nixpkgs/blob/2230a20f2b5a14f2db3d7f13a2dc3c22517e790b/nixos/modules/tasks/auto-upgrade.nix#L255
  # Also note that this doesn't upgrade or downgrade the non-declarative files that are defined in nix.sh/build.
  systemd.services.nixos-upgrade.script =
    lib.mkForce "${config.system.build.nixos-rebuild}/bin/nixos-rebuild ${config.system.autoUpgrade.operation} ${builtins.toString config.system.autoUpgrade.flags}";
}
