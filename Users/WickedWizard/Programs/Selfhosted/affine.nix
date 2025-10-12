{ pkgs, ... }:
{
  home.packages = with pkgs; [ affine-bin ];
  programs.autostart.packages = with pkgs; [ affine-bin ];

  system-config.nixpkgs.config.permittedInsecurePackages = [ "electron-35.7.5" ];
}
