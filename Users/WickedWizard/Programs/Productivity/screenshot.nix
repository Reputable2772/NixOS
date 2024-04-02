{ config, pkgs, lib, ... }:
let
  hyprland = config.wayland.windowManager.hyprland.enable;
in
{
  home.packages = (with pkgs; [ tesseract ]) ++ (lib.optionals hyprland (with pkgs; [
    grim
    slurp
    swappy
  ]));

  services.flameshot = {
    enable = !hyprland;
    settings = {
      General = {
        autoCloseIdleDaemon = true;
        contrastOpacity = 188;
        copyOnDoubleClick = true;
        copyPathAfterSave = false;
        saveAfterCopy = true;
        undoLimit = 100;
        uploadWithoutConfirmation = true;
      };
      Shortcuts = {
        TYPE_IMAGEUPLOADER = "Ctrl+V";
      };
    };
  };

  xdg.configFile = {
    swappy_config = {
      enable = hyprland;
      target = "swappy/config";
      text = ''
        [Default]
        save_dir=$HOME/Pictures/Screenshots
        save_filename_format=swappy-%Y%m%d-%H%M%S.png
        show_panel=true
        line_size=5
        text_size=20
        text_font=sans-serif
        paint_mode=brush
        early_exit=true
        fill_shape=false
      '';
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
    "SUPER SHIFT, Print, exec, grim -g \"$(slurp)\" /tmp/tmp.png && tesseract -l eng /tmp/tmp.png - | wl-copy && rm /tmp/tmp.png && notify-send \"OCR copied!\""
  ];
}
