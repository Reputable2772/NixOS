{ config, pkgs, ... }: {
  home.packages = with pkgs; [ mullvad-browser ];

  xdg.configFile."autostart/mullvad-browser.desktop".source = "${pkgs.mullvad-browser}/share/applications/mullvadbrowser.desktop";
}
