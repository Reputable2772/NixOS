{
  config,
  lib,
  options,
  ...
}:
let
  inherit (lib.strings) optionalString;
in
{
  options.secretspec = { };

  config = {
    secretspec = {
      files.${config.networking.hostName}."Config/Secrets/${config.networking.hostName}.age" =
        ./. + "../../../../Config/Secrets/${config.networking.hostName}.age";
      config = {
        project = {
          name = "System - ${config.networking.hostName}";
          revision = "1.0";
        };

        # Runs early in initrd, provide private key path from /persist if necessary
        providers.${config.networking.hostName} =
          "age://Config/Secrets/${config.networking.hostName}.age?identity=${
            optionalString (options.environment ? persistence) "/persist"
          }/etc/ssh/${config.networking.hostName}&recipients=${
            optionalString (options.environment ? persistence) "/persist"
          }/etc/ssh/${config.networking.hostName}.pub";

        profiles.${config.networking.hostName} = {
          defaults = {
            required = true;
            providers = [ config.networking.hostName ];
          };
        };
      };
    };
  };
}
