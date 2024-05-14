{ pkgs, ... }: {
  home.packages = with pkgs; [ schildichat-desktop ];

  # programs.autostart.packages = with pkgs; [ schildichat-desktop ];
}
