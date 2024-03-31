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

  programs.autostart.autostartPackages = [
    (bool cond pkgs.gnome.pomodoro (
      pkgs.makeDesktopItem {
        name = "Uair";
        exec = "uair %u";
        desktopName = "pomodoro";
        categories = [ "Applications" ];
      }
    ))
  ];

  xdg.configFile = {
    uair_config = {
      enable = bool cond false true;
      target = "uair/uair.toml";
      text = ''
        [defaults]
        format = "{time}\n"

        [[sessions]]
        id = "work"
        name = "Work"
        duration = "45m"
        command = "notify-send 'Work Done!'"

        [[sessions]]
        id = "rest"
        name = "Rest"
        duration = "5m"
        command = "notify-send 'Rest Done!'"
      '';
    };
  };
}
