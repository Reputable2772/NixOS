{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dnsutils
    rmtrash
  ];

  # Required for eza
  fonts.fontconfig.enable = true;

  programs.shells = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ip = "ip -color";
      rm = "rmtrash";
      rmdir = "rmtrash";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
  };
}
