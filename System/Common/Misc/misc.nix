{
  inputs,
  config',
  lib,
  ...
}:
{
  time.timeZone = config'.system.timezone;
  i18n.defaultLocale = config'.system.locale;

  i18n.extraLocaleSettings = lib.genAttrs [
    "LC_ADDRESS"
    "LC_IDENTIFICATION"
    "LC_MEASUREMENT"
    "LC_MONETARY"
    "LC_NAME"
    "LC_NUMERIC"
    "LC_PAPER"
    "LC_TELEPHONE"
    "LC_TIME"
  ] (_: config'.system.locale);

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system.stateVersion = "26.05";

  system.systemBuilderCommands = "ln -s ${inputs.self} $out/src";
}
