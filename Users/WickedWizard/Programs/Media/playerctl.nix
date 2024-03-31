{ pkgs, ... }: {
  home.packages = with pkgs; [ playerctl ];

  programs.autostart.autostartPackages = [
    (pkgs.makeDesktopItem {
      name = "Playerctld";
      exec = "playerctld daemon";
      desktopName = "Playerctld";
      categories = [ "Applications" ];
    })
  ];
}
