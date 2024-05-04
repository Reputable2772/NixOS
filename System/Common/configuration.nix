{
  time.timeZone = "Asia/Kolkata";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  imports = [
    ../../Modules/System
  ];

  system.stateVersion = "23.05";
}

