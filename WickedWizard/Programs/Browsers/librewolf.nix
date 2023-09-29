{ config, pkgs, ... }: {
  home.packages = with pkgs; [ librewolf ];

  # xdg.configFile."autostart/librewolf.desktop".source = "${pkgs.librewolf}/share/applications/librewolf.desktop";
}
