{ pkgs, ... }: {
  home.packages = with pkgs; [
    dconf2nix
    gnome.gnome-terminal
    gnome.dconf-editor
  ];
}
