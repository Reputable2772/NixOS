{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optionals config.wayland.windowManager.hyprland.enable [
    pkgs.wl-clipboard
    pkgs.copyq
  ];

  wayland.windowManager.hyprland.settings = {
    on = [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("${lib.getExe config.services.copyq.package}")
            end
          '')
        ];
      }
    ];
    bind = [
      {
        _args = [
          "SUPER + C"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("copyq toggle")'')
        ];
      }
    ];
    window_rule = [
      {
        match = {
          initial_class = "com.github.hluk.copyq";
        };
        float = true;
        opaque = true;
        dim_around = true;
        stay_focused = true;
      }
    ];
  };
}
