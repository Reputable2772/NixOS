{ osConfig, pkgs, ... }:
{
  home.packages = with pkgs; [
    (if osConfig.services.desktopManager.plasma6.enable then kdePackages.kate else gnome-text-editor)
  ];
}
