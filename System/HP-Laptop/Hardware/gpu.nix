{
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
  };
}
