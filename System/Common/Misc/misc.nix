{ config', ... }:
{
  time.timeZone = config'.system.timezone;
  i18n.defaultLocale = config'.system.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system.stateVersion = "26.05";

  system.systemBuilderCommands = "ln -s ${../../..} $out/src";
}
