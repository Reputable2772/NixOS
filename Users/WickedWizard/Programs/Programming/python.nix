{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    python3Full
    python311Packages.pip
  ];
}