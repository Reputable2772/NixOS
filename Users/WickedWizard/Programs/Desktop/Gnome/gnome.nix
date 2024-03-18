{ pkgs, ... }: {
  # Required even if Gnome is not installed
  home.packages = with pkgs; [ dconf2nix ];

  programs.gnome = {
    enable = false;
    extensions = with pkgs.gnomeExtensions; [
      appindicator
      bluetooth-battery
      caffeine
      just-perfection
      pano
      rounded-window-corners
      vitals
    ];
    gnomeOnlyPackages = with pkgs.gnome; [
      gnome-terminal
      dconf-editor
    ];
  };
}
