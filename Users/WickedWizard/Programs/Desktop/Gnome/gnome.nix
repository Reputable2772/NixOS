{ pkgs, ... }: {
  # Required even if Gnome is not installed
  home.packages = with pkgs; [ dconf2nix ];

  programs.gnome = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      appindicator
      bluetooth-battery
      caffeine
      gsconnect
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
