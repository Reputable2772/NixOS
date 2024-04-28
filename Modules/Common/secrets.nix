{ lib, ... }:
with lib;
{
  options.programs.secrets = {
    secrets = mkOption {
      type = types.anything;
      description = ''
        Set all the secrets here, so that it can be accessed easily.
      '';
    };
  };
}
