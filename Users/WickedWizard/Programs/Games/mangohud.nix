{ config, ... }:
{
  programs.mangohud = {
    enable = true;
    settings = {
      fps_metrics = 1.0e-2;
    };
  };

  stylix.targets.mangohud.enable = config.programs.mangohud.enable;

  services.flatpak.overrides.global.Context.filesystems = [ "xdg-config/Mangohud:ro" ];

  services.flatpak.packages = [
    # Don't know which, these 'just' work with Lutris
    "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08"
    "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08"
    "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/25.08"
  ];
}
