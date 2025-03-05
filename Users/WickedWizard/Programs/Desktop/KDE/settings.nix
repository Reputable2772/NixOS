{
  inputs,
  osConfig,
  config,
  ...
}:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  stylix.targets.kde.enable = config.programs.plasma.enable;

  programs.plasma = {
    enable = osConfig.services.desktopManager.plasma6.enable;

    input.keyboard.numlockOnStartup = "on";

    /**
      TODO:
        Declare
          Meta + E for Dolphin
          Meta + . for Emoji Selector
        under services/ in shortcuts.
    */
    shortcuts = {
      kwin = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "Kill Window" = "Meta+Ctrl+Esc";
        "Show Desktop" = "Meta+D";
        "Switch One Desktop Down" = "Meta+Ctrl+Down";
        "Switch One Desktop Up" = "Meta+Ctrl+Up";
        "Switch to Desktop 1" = "Meta+1,Ctrl+F1,Switch to Desktop 1";
        "Switch to Desktop 2" = [
          "Ctrl+F2"
          "Meta+2,Ctrl+F2,Switch to Desktop 2"
        ];
        "Switch to Desktop 3" = [
          "Meta+3"
          "Ctrl+F3,Ctrl+F3,Switch to Desktop 3"
        ];
        "Switch to Desktop 4" = [
          "Meta+4"
          "Ctrl+F4,Ctrl+F4,Switch to Desktop 4"
        ];
        "Switch to Desktop 5" = "Meta+5,,Switch to Desktop 5";
        "Switch to Desktop 6" = "Meta+6,,Switch to Desktop 6";
        "Switch to Desktop 7" = "Meta+7,,Switch to Desktop 7";
        "Switch to Desktop 8" = "Meta+8,,Switch to Desktop 8";
        "Switch to Desktop 9" = "Meta+9,,Switch to Desktop 9";
        "Switch to Next Desktop" = "Ctrl+Alt+Right,,Switch to Next Desktop";
        "Switch to Previous Desktop" = "Ctrl+Alt+Left,,Switch to Previous Desktop";
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Window Close" = [
          "Alt+F4"
          "Meta+Q,Alt+F4,Close Window"
        ];
        "Window Fullscreen" = [
          "Meta+F"
          "F11,,Make Window Fullscreen"
        ];
        "Window Maximize" = [
          ""
          "Meta+M,Meta+PgUp,Maximize Window"
        ];
        "Window One Desktop to the Left" =
          "Meta+Ctrl+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left";
        "Window One Desktop to the Right" =
          "Meta+Ctrl+Right,Meta+Ctrl+Shift+Right,Window One Desktop to the Right";
        "Window to Desktop 1" = "Meta+Ctrl+1,,Window to Desktop 1";
        "Window to Desktop 2" = "Meta+Ctrl+2,,Window to Desktop 2";
        "Window to Desktop 3" = "Meta+Ctrl+3,,Window to Desktop 3";
        "Window to Desktop 4" = "Meta+Ctrl+4,,Window to Desktop 4";
        "Window to Desktop 5" = "none,,Window to Desktop 5";
        "Window to Desktop 6" = "none,,Window to Desktop 6";
        "Window to Desktop 7" = "none,,Window to Desktop 7";
        "Window to Desktop 8" = "none,,Window to Desktop 8";
        "Window to Desktop 9" = "none,,Window to Desktop 9";
        "Window to Previous Desktop" = "none,,Window to Previous Desktop";
        "Window to Next Desktop" = "none,,Window to Next Desktop";
      };

      "services/org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";

      mediacontrol = {
        "mediavolumedown" = "none,,Media volume down";
        "mediavolumeup" = "none,,Media volume up";
        "nextmedia" = "Media Next";
        "pausemedia" = "Media Pause";
        "playmedia" = "none,,Play media playback";
        "playpausemedia" = "Media Play";
        "previousmedia" = "Media Previous";
        "stopmedia" = "Media Stop";
      };

      kmix = {
        "decrease_microphone_volume" = "Microphone Volume Down";
        "decrease_volume" = "Volume Down";
        "decrease_volume_small" = "Shift+Volume Down";
        "increase_microphone_volume" = "Microphone Volume Up";
        "increase_volume" = "Volume Up";
        "increase_volume_small" = "Shift+Volume Up";
        "mic_mute" = [
          "Microphone Mute"
          "Meta+Volume Mute,Microphone Mute"
          "Meta+Volume Mute,Mute Microphone"
        ];
        "mute" = "Volume Mute";
      };

      ksmserver = {
        "Halt Without Confirmation" = [ ];
        "Lock Session" = [
          "Meta+L"
          "Screensaver,Meta+L"
          "Screensaver,Lock Session"
        ];
        "Log Out" = "Ctrl+Alt+Del";
        "Log Out Without Confirmation" = [ ];
        "LogOut" = [ ];
        "Reboot" = [ ];
        "Reboot Without Confirmation" = [ ];
        "Shut Down" = [ ];
      };
    };
  };
}
