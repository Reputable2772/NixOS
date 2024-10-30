{ pkgs, ... }: {
  home.packages = with pkgs; [ bitwarden-desktop bitwarden-cli ];

  # programs.autostart.packages = with pkgs; [ bitwarden ];
}
