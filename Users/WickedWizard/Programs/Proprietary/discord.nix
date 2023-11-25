{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    (discord.override {
      # withOpenASAR = true;
      withVencord = true;
    })
  ];

  # xdg.configFile."autostart/discord.desktop".source = "${pkgs.discord}/share/applications/discord.desktop";
}
