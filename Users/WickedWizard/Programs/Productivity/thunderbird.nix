{ config', pkgs, lib, ... }: {
  home.packages = with pkgs; [ thunderbird ];

  home.file.".thunderbird/profiles.ini".text = ''
    [Profile0]
    Name=Thunderbird
    IsRelative=0
    ${lib.optionals (config'.dir ? browsers) "Path=${config'.dir.browsers}/Thunderbird"}
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  programs.autostart.packages = with pkgs; [ thunderbird ];
  programs.firejail.excludedPackages = with pkgs; [ thunderbird ];
}
