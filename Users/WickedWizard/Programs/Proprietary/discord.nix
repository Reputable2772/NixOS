{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    (discord.override {
      # remove any overrides that you don't want
      withOpenASAR = true;
      withVencord = true;
    })
  ];

  # xdg.configFile."autostart/discord.desktop".source = "${pkgs.discord}/share/applications/discord.desktop";
}
