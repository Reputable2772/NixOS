{ pkgs, ... }: {
  home.packages = with pkgs; [ playerctl ];

  xdg.configFile."autostart/playerctd.desktop".source = ''
    [Desktop Entry]
    Version=1.0
    Name=playerctld
    GenericName=Playerctl daemon
    Comment=Playerctl daemon
    Exec=${pkgs.playerctl}/bin/playerctld daemon
    Terminal=false
    Type=Application
    Categories=Utility;
    StartupNotify=true
    Hidden=true
  '';
}
