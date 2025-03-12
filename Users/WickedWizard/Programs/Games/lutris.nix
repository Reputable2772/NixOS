{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (lutris.override {
      # Since steam is a flatpak.
      steamSupport = false;
    })
  ];
}
