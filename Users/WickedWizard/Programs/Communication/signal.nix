{ config, pkgs, ... }: {
  home.packages = with pkgs; [ signal-desktop ];

  xdg.configFile."autostart/signal.desktop".source = "${pkgs.signal-desktop}/share/applications/signal-desktop.desktop";
}
