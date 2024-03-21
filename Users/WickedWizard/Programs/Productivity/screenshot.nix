{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tesseract

    (lib.mkIf
      (config.programs.hyprland.enable)
      grim)
    (lib.mkIf
      (config.programs.hyprland.enable)
      slurp)
    (lib.mkIf
      (!config.programs.hyprland.enable)
      flameshot)
  ];

  services.flameshot = {
    enable = !config.programs.hyprland.enable;
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
}
