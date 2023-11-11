{ config, pkgs, ... }: {
  imports = [
    ./bottles.nix
    ./qemu.nix
  ];
}
