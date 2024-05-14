{ pkgs, ... }: {
  home.packages = with pkgs; [ mullvad-browser ];

  # programs.autostart.packages = with pkgs; [ mullvad-browser ];
}
