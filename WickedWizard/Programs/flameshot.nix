{ config, pkgs, ... }: {
  home.packages = with pkgs; [ flameshot ];

  xdg.configFile."flameshot/flameshot.ini".text = ''
    [General]
    autoCloseIdleDaemon=true
    contrastOpacity=188
    copyOnDoubleClick=true
    copyPathAfterSave=false
    saveAfterCopy=true
    undoLimit=100
    uploadWithoutConfirmation=true

    [Shortcuts]
    TYPE_IMAGEUPLOADER=Ctrl+V
  '';
}
