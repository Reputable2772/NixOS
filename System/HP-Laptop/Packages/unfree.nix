{ pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "beeper"
    "discord"
    "spotify"
    "steam"
    "steam-original"
    "steam-run"
  ];

  programs.steam.enable = true;
}
