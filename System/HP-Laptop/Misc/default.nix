{ config, ... }: {
  imports = [
    ./sudo.nix
  ]
  ++ lib.optional (config.programs.hyprland.enable) ./xdg-systemd.nix;
}
