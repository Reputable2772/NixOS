{ config, pkgs, ... }: {
  programs.kodi = {
    enable = true;
    datadir = "${config.home.homeDirectory}/Documents/Config/Kodi/";
    package = pkgs.kodi-wayland.withPackages (exts: with exts; [ pvr-iptvsimple ]);
  };
}
