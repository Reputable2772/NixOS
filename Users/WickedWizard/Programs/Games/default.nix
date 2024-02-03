{ config, pkgs, ... }: {
  imports = [
    ./heroic.nix
    ./prismlauncher-qt5.nix
    ./lutris.nix
  ];
}
