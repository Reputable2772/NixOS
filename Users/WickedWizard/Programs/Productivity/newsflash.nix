{ pkgs, ... }: {
  home.packages = with pkgs; [ newsflash ];

  programs.autostart.packages = with pkgs; [ newsflash ];
}
