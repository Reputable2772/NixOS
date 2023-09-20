{ config, pkgs, ... }: {
  home.packages = with pkgs; [ beeper ];

  xdg.configFile."autostart/beeper.desktop".source = "${pkgs.beeper}/share/applications/beeper.desktop";
}
