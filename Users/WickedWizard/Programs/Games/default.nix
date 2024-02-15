{ config, pkgs, ... }: {
  imports = [
    ./heroic.nix
    ./lutris.nix
    ./mangohud.nix
    ./prismlauncher-qt5.nix
  ];
}
