{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    libsecret
    lazygit
  ];

  programs.git = {
    enable = true;
    userEmail = "153411261+Reputable2772@users.noreply.github.com";
    userName = "Reputable2722";
    extraConfig = {
      gpg = {
        format = "ssh";
      };
    };
    signing = {
      key = "/home/wickedwizard/Documents/Dotfiles/Scripts/SSH/id_rsa.pub";
      signByDefault = true;
    };
  };
}
