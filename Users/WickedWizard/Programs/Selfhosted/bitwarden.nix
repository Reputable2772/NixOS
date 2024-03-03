{ pkgs, ... }: {
  home.packages = with pkgs; [ bitwarden bitwarden-cli ];

  xdg.configFile."autostart/bitwarden.desktop".source = "${pkgs.bitwarden}/share/applications/bitwarden.desktop";
}
