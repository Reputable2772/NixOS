{ config', ... }:
{
  time.timeZone = config'.system.timezone;
  i18n.defaultLocale = config'.system.locale;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system.stateVersion = "26.05";

  system.systemBuilderCommands = "ln -s ${../../..} $out/src";
}
