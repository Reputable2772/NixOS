{ osConfig, ... }:
{
  services.flatpak.packages = [
    (if osConfig.services.desktopManager.gnome.enable then "org.gnome.TextEditor" else "org.kde.kate")
  ];
}
