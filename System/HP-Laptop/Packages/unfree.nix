{ pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "spotify"
    "beeper"
    "steam"
    "steam-original"
    "steam-run"
  ];
}
