{ config, pkgs, ... }: {
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/Documents/Config/GPG/";
  };
}
