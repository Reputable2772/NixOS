{ pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "spotify"
    "beeper"
    "android-studio-stable"
  ];
}
