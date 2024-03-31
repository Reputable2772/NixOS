{ pkgs, ... }: {
  home.packages = with pkgs; [ newsflash ];

  programs.autostart.autostartPackages = with pkgs; [ newsflash ];
}
