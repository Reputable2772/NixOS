{ pkgs, ... }: {
  home.packages = with pkgs; [ mullvad-browser ];

  # programs.autostart.autostartPackages = with pkgs; [ mullvad-browser ];
}
