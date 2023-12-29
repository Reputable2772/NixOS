{ config, pkgs, ... }: {
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      KernelExperimental = true;
    };
  };
}
