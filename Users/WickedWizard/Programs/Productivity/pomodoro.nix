{ osConfig, pkgs, ... }:
let
  bool = c: t: f:
    if c
    then t
    else f;
  cond = osConfig.services.xserver.desktopManager.gnome.enable;
in
{
  home.packages = with pkgs; [
    (bool cond gnome.pomodoro uair)
  ];

  xdg.configFile.pomodoro = {
    enable = true;
    target = "autostart/pomodoro.desktop";
    source = bool cond "${pkgs.gnome.pomodoro}/share/applications/org.gnome.Pomodoro.desktop" (pkgs.makeDesktopItem {
      name = "Uair";
      exec = "uair %u";
      desktopName = "Uair";
      categories = [ "Applications" ];
    });
  };
}
