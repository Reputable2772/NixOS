{
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      horizontalScrolling = true;
    };
    touchpad = {
      accelProfile = "flat";
      disableWhileTyping = true;
      horizontalScrolling = true;
      naturalScrolling = false;
      scrollMethod = "twofinger";
      tappingButtonMap = "lrm";
      tapping = true;
    };
  };
}
