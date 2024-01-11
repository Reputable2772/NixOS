{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    flameshot
    tesseract
    wl-clipboard
  ];

  services.flameshot = {
    enable = true;
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
