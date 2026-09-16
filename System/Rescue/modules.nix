# This file is generally meant to be used for
# reverting common config set in Systems/Common.
{ lib, ... }: {
  options.secretspec = lib.mkSinkUndeclaredOptions { };
  options.home-manager = lib.mkSinkUndeclaredOptions { };

  config = {
    systemd.services.ip-update = lib.mkForce { };
    systemd.timers.ip-update = lib.mkForce { };
  };
}
