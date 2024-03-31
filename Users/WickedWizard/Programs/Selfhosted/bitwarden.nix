{ pkgs, ... }: {
  home.packages = with pkgs; [ bitwarden bitwarden-cli ];

  # programs.autostart.autostartPackages = with pkgs; [ bitwarden ];
}
