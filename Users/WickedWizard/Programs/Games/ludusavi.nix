{
  config,
  config',
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ ludusavi ];

  # We need backup for ludusavi.
  programs.backup.preBackupScript = ''
    ${lib.getExe pkgs.ludusavi} --config ${config.xdg.configHome}/ludusavi backup --force
  '';

  xdg.configFile."ludusavi/config.yaml".source =
    (pkgs.formats.yaml { }).generate "ludusavi-config"
      config'.backup.ludusavi;
}
