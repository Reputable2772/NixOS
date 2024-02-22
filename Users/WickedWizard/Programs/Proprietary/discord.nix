{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    vesktop
  ];

  # xdg.configFile."autostart/discord.desktop".source = "${pkgs.discord}/share/applications/discord.desktop";
}
