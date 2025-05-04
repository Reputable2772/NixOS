{ pkgs, ... }:
{
  home.packages = with pkgs; [ feishin ];

  system-config.nixpkgs.config.permittedInsecurePackages = [ "electron-33.4.11" ];
}
