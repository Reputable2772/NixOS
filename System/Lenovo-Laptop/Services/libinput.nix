{ lib, ... }:
{
  services.libinput = {
    enable = true;
    mouse = lib.mkForce {
      accelProfile = "flat";
      horizontalScrolling = true;
    };
    touchpad = lib.mkForce {
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
