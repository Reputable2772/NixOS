{ osConfig, lib, ... }:
{
  options.programs.gnome.enable = lib.mkEnableOption "GNOME" // {
    default = osConfig.services.xserver.desktopManager.gnome.enable;
  };
}
