{ config, config', pkgs, lib, ... }: {
  home.packages = with pkgs; [ thunderbird ];

  home.file.".thunderbird/profiles.ini".text = ''
    [Profile0]
    Name=Thunderbird
    IsRelative=0
    ${lib.optionals (lib.attrsets.hasAttrByPath [ "config" "dir" "browsers" ] config'.users.${config.home.username}) "Path=${config'.users.${config.home.username}.config.dir.browsers}/Thunderbird"}
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  programs.autostart.packages = with pkgs; [ thunderbird ];
}
