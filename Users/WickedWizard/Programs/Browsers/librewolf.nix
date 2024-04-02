{
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting.letterboxing" = true;
      "network.http.referer.XOriginPolicy" = 2;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
    };
  };

  # programs.autostart.autostartPackages = with pkgs; [ librewolf ];

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, B, exec, librewolf"
  ];
}
