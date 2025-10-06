{ pkgs, ... }:
{
  hardware = {
    cpu.intel.updateMicrocode = true;
    intel-gpu-tools.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
  };

  environment.sessionVariables = {
    "VDPAU_DRIVER" = "va_gl";
    "ANV_DEBUG" = "video-decode,video-encode";
  };
}
