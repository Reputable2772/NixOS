{
  programs.mangohud = {
    enable = true;
    settings = {
      fps_metrics = 1.0e-2;
    };
  };

  services.flatpak.packages = [ "org.freedesktop.Platform.VulkanLayer.MangoHud" ];
}
