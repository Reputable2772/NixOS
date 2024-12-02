{
  programs.mangohud = {
    enable = true;
    settings = {
      fps_metrics = 1.0e-2;
    };
  };

  services.flatpak.packages = [
    "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08"
  ];
}
