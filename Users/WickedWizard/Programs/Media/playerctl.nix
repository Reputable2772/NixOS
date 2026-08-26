{ pkgs, ... }:
{
  home.packages = with pkgs; [ playerctl ];

  xdg.autostart.packages = [
    (pkgs.makeDesktopItem {
      name = "Playerctld";
      exec = "playerctld daemon";
      desktopName = "Playerctld";
      categories = [ "Applications" ];
    })
  ];
}
