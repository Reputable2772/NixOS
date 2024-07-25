{ config', pkgs, ... }: {
  home.packages = with pkgs; [ ludusavi ];

  xdg.configFile."ludusavi/config.yaml".source = (pkgs.formats.yaml { }).generate "ludusavi-config" config'.backup.ludusavi;
}
