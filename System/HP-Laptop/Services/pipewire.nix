{
  services.pipewire = {
    enable = true;
    # Seems to be an ALSA issue https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3622
    # alsa.enable = false;
    # alsa.support32Bit = f;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
