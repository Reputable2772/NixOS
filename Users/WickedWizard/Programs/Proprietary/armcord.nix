{ config, pkgs, ... }: {
  home.packages = with pkgs; [ armcord ];

  # xdg.configFile."autostart/armcord.desktop".source = "${pkgs.armcord}/share/applications/armcord.desktop";
}
