{ config, lib, pkgs, ... }: {
  # Our config is symlinked to /etc/nixos, no matter where it is.
  # nix.sh/first-time-setup takes care of it.

  systemd.services.pull_flake = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ git ];
    script = ''
      cd /etc/nixos
      git pull --verbose --autostash --all
    '';

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  systemd.timers.pull_flake = {
    wantedBy = [ "timers.target" ];
    partOf = [ "pull_flake.service" ];
    timerConfig = {
      Persistent = true;
      # Run it 10mins before, to pull flake
      OnCalendar = "*-*-* 23:50:00 ${config.time.timeZone}";
      Unit = "pull_flake.service";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "\"$(readlink -f /etc/nixos)\"";
    flags = [
      "-L"
    ];
    dates = "*-*-* 00:00:00 ${config.time.timeZone}";
  };

  # We don't need the upgrade flag due to the CI doing it for us. https://github.com/NixOS/nixpkgs/blob/2230a20f2b5a14f2db3d7f13a2dc3c22517e790b/nixos/modules/tasks/auto-upgrade.nix#L255
  systemd.services.nixos-upgrade.script =
    lib.mkForce "${config.system.build.nixos-rebuild}/bin/nixos-rebuild ${config.system.autoUpgrade.operation} ${builtins.toString config.system.autoUpgrade.flags}";
}
