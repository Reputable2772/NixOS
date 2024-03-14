# Fixes https://github.com/NixOS/nixpkgs/issues/189851#issuecomment-1238907955
{ config, lib, ... }: {
  systemd.user.extraConfig = lib.mkIf (config.programs.hyprland.enable) ''
    DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
  '';
}
