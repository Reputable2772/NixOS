{ config, pkgs, ... }: {
  imports = [
    ./cartridge.nix
    ./prismlauncher.nix
  ];
}
