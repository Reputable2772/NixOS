{ config, pkgs, ... }: {
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/Documents/Config/GPG/";
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
}
