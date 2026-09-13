{
  config,
  config',
  pkgs,
  lib,
  inputs,
  ...
}:
let
  encryptionKey = config'.system.${config.networking.hostName}.secrets.encryption or { };
in
{
  secretspec = lib.optionalAttrs (encryptionKey != null && encryptionKey != { }) {
    providerFiles.${config.networking.hostName}."Config/Secrets/${config.networking.hostName}.age" =
      inputs.self + "/Config/Secrets/${config.networking.hostName}.age";
    config = {
      project = {
        name = "System - ${config.networking.hostName}";
        revision = "1.0";
      };

      providers.${config.networking.hostName} =
        "age://Config/Secrets/${config.networking.hostName}.age?identity=${encryptionKey.pkeyfile}&recipients=${pkgs.writeText "${config.networking.hostName}.pub" encryptionKey.key}";

      profiles.${config.networking.hostName} = {
        defaults = {
          required = true;
          providers = [ config.networking.hostName ];
        };
      };
    };
  };

  home-manager.sharedModules = [
    (
      { config, config', ... }:
      let
        userEncryptionKey = config'.secrets.encryption or { };
      in
      {
        secretspec = lib.optionalAttrs (userEncryptionKey != null && userEncryptionKey != { }) {
          providerFiles.${config.home.username}."Config/Secrets/${config.home.username}.age" =
            inputs.self + "/Config/Secrets/${config.home.username}.age";

          config = {
            project = {
              name = "Home-Manager - ${config.home.username}";
              revision = "1.0";
            };

            providers.${config.home.username} =
              "age://Config/Secrets/${config.home.username}.age?identity=${userEncryptionKey.pkeyfile}&recipients=${pkgs.writeText "${config.home.username}.pub" userEncryptionKey.key}";

            profiles.${config.home.username} = {
              defaults = {
                required = true;
                providers = [ config.home.username ];
              };
            };
          };
        };
      }
    )
  ];
}
