{ pkgs, ... }:
{
  home.packages = with pkgs; [ affine ];

  system-config.nixpkgs.config.permittedInsecurePackages = [ "electron-35.7.5" ];
}
