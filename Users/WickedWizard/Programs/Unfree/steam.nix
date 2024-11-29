{ config, ... }:
{
  services.flatpak.packages = [
    "com.valvesoftware.Steam"
    "io.github.Foldex.AdwSteamGtk"
  ];

  # MangoHud's settingsPerApplication is unnecessary and useless here. Set all options for steam mangohud through this file itself.
  home.file.".var/app/com.valvesoftware.Steam/config/MangoHud/MangoHud.conf" =
    config.xdg.configFile."MangoHud/MangoHud.conf"
    // {
      target = ".var/app/com.valvesoftware.Steam/config/MangoHud/MangoHud.conf";
    };
}
