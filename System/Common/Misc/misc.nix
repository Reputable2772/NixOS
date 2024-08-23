{ config', ... }: {
  time.timeZone = config'.system.timezone;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system.stateVersion = "23.05";
}

