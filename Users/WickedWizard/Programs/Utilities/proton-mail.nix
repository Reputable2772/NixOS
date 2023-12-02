{ config, pkgs, ... }: {
  home.packages = with pkgs; [ electron-mail ];

  xdg.configFile."autostart/electron-mail.desktop".source = "${pkgs.electron-mail}/share/applications/electron-mail.desktop";
}
