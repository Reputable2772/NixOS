{ config, config', lib, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting.letterboxing" = true;
      "network.http.referer.XOriginPolicy" = 2;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
    };
  };

  home.file.".librewolf/profiles.ini".text = ''
    [Profile0]
    Name=Default
    IsRelative=0
    ${lib.optionals (lib.attrsets.hasAttrByPath [ "config" "dir" "browsers" ] config'.users.${config.home.username}) "Path=${config'.users.${config.home.username}.config.dir.browsers}/Librewolf"}

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  # programs.autostart.autostartPackages = with pkgs; [ librewolf ];

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, B, exec, librewolf"
  ];
}
