{ osConfig, lib, ... }:
{
  options.programs.gnome.enable = lib.mkEnableOption "GNOME" // {
    default = osConfig.services.desktopManager.gnome.enable;
  };
}
