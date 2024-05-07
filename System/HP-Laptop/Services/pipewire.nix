{
  services.pipewire = {
    enable = true;
    # Seems to be an ALSA issue https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3622
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
