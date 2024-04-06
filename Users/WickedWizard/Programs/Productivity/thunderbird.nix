{ config, pkgs, ... }: {
  home.packages = with pkgs; [ thunderbird ];

  home.file.".thunderbird/profiles.ini".text = ''
    [Profile0]
    Name=Thunderbird
    IsRelative=0
    Path=${config.home.homeDirectory}/Documents/Browsers/Thunderbird
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  programs.autostart.autostartPackages = with pkgs; [ thunderbird ];
}
