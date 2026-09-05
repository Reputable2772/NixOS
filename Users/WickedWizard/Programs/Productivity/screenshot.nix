{
  sources,
  config,
  pkgs,
  lib,
  ...
}:
let
  hyprland = config.wayland.windowManager.hyprland.enable;
in
{
  # Fixes nix-community/home-manager#2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  programs.nvfetcher.config."0x0" = lib.mkIf hyprland {
    fetch.git = "https://github.com/Calinou/0x0.git";
    src.git = "https://github.com/Calinou/0x0.git";
  };

  home.packages =
    (with pkgs; [ tesseract ])
    ++ (lib.optionals hyprland (
      with pkgs;
      [
        grim
        slurp
        swappy
        # Already has a bin folder, so that'll be
        # directly copied to PATH
        sources."0x0".src
      ]
    ));

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
        save_filename_format=swappy-%Y-%m-%d_%H-%M-%S.png
        show_panel=true
        line_size=5
        text_size=20
        auto_save=true
        text_font=sans-serif
        paint_mode=brush
        early_exit=true
        fill_shape=false
      '';
    };
  };

  /**
    TODO: Upload to 0x0

    Screenshoting Cheatsheet
    PrintScreen - Region Selection + Swappy for annotations
    SHIFT - No region selection
    CTRL - No swappy
    SUPER + SHIFT - OCR
  */

  wayland.windowManager.hyprland.settings.bind = [
    # Swappy
    ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
    ''SHIFT, Print, exec, grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | swappy -f -''

    # Direct
    "CTRL, Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/region-$(date +%Y-%m-%d_%H-%M-%S).png"
    ''CTRL SHIFT, Print, exec, grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" ~/Pictures/Screenshots/window-$(date +%Y-%m-%d_%H-%M-%S).png''

    # OCR
    ''SUPER SHIFT, Print, exec, sh -c 'file="$HOME/Pictures/Screenshots/ocr-$(date +%Y-%m-%d_%H-%M-%S).png"; grim -g "$(slurp)" "$file" && tesseract -l eng "$file" - | wl-copy && notify-send "OCR copied!"''

    # Upload to 0x0
    "CTRL SHIFT SUPER, Print, exec, grim -g \"$(slurp)\" - | swappy -f - -o - | 0x0 - | wl-copy"
  ];
}
