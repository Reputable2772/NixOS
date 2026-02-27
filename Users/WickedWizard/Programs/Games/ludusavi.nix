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
  services.restic.preBackupScript = [
    ''
      ${lib.getExe pkgs.ludusavi} --try-manifest-update --config ${config.xdg.configHome}/ludusavi backup --force
    ''
  ];

  xdg.configFile."ludusavi/config.yaml".source =
    (pkgs.formats.yaml { }).generate "ludusavi-config"
      config'.backup.ludusavi;
}
