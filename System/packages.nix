{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gitFull
    curl
    nano
  ];

  environment.pathsToLink = [ "/share/Kvantum" ];
}
