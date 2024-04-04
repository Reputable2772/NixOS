{ pkgs, ... }: {
  home.packages = with pkgs; [ thunderbird ];

  home.file.".thunderbird/profiles.ini".text = ''
    [Profile1]
    Name=Thunderbird
    IsRelative=0
    Path=/home/wickedwizard/Documents/Browsers/Thunderbird
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';
}
