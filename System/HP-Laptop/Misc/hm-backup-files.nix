{ config, pkgs, ... }:
{
  systemd.services.home-manager-wickedwizard.preStart = "(${pkgs.findutils}/bin/find ${config.users.users.wickedwizard.home}/.* -type f -name '*.backup.backup.backup' -exec ${pkgs.coreutils}/bin/rm -v {} \\; 2> /dev/null || exit 0)";
}
