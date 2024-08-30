{ pkgs, ... }: {
  home.packages = with pkgs; [
    lutris

    # Fixes NixOS/nixpkgs#285748
    winetricks
  ];
}
