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
    "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08"
  ];
}
