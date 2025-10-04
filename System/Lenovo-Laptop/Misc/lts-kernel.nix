{ pkgs, lib, ... }:
{
  specialisation.lts-kernel.configuration = {
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
  };
}
