{ pkgs, ... }: {
  home.packages = with pkgs; [ bitwarden bitwarden-cli ];

  # programs.autostart.packages = with pkgs; [ bitwarden ];
}
