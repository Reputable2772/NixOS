{ pkgs, ... }: {
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.variables = {
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      setLdLibraryPath = true;

      # Vulkan
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        # OpenCL
        rocmPackages.clr.icd

        # Vulkan
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };
}
