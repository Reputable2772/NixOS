{ config, pkgs, ... }: {
  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  environment.variables = {
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };

  nixpkgs.config.allowUnfree = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
