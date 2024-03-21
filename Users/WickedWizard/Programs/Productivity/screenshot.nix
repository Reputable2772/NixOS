{ config, pkgs, ... }:
{
  home.packages = (with pkgs; [ tesseract ]) ++ (if (config.wayland.windowManager.hyprland.enable) then
    (with pkgs; [
      grim
      slurp
      swappy
    ])
  else (with pkgs; [ flameshot ]));

  services.flameshot = {
    enable = !config.wayland.windowManager.hyprland.enable;
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

  xdg.configFile."swappy/config".text = ''
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
}
