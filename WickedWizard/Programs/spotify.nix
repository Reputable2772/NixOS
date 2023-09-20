{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nur.repos.nltch.spotify-adblock
  ];

  xdg.configFile."autostart/spotify-adblock.desktop".source = "${pkgs.nur.repos.nltch.spotify-adblock}/share/applications/spotify.desktop";
}
