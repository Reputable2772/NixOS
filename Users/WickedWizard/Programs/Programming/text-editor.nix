{ osConfig, ... }:
{
  services.flatpak.packages = [
    (
      if osConfig.services.xserver.desktopManager.gnome.enable then
        "org.gnome.TextEditor"
      else
        "org.kde.kate"
    )
  ];
}
