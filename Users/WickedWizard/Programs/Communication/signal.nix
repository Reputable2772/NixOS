{ pkgs, ... }: {
  home.packages = with pkgs; [ signal-desktop ];

  # programs.autostart.autostartPackages = with pkgs; [ signal-desktop ];
}
