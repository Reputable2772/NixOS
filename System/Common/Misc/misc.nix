{ config', ... }: {
  time.timeZone = config'.system.timezone;
  i18n.defaultLocale = config'.system.locale;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system.stateVersion = "23.05";

  system.extraSystemBuilderCmds = "ln -s ${../../..} $out/src";
}

