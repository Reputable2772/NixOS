{ config, pkgs, inputs, ... }:
{
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${pkgs.hostPlatform.system}.nix-ld-rs;
  };

  environment.systemPackages = with pkgs; [
    gitFull
    curl
    nano
  ];
}
