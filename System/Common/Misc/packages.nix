{ pkgs, ... }:
{
  programs.git.enable = true;
  programs.nano.enable = true;

  environment.systemPackages = with pkgs; [
    curl
  ];
}
