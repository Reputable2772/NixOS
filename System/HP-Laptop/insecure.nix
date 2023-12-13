{ config, pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
