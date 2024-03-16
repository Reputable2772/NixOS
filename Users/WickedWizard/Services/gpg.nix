{ config, ... }: {
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/Documents/Config/GPG/";
  };
  services.gpg-agent = {
    enable = false;
    enableSshSupport = true;
    pinentryPackage = "gnome3";
  };
}
