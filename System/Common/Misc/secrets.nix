# This module is responsible for loading secrets for all users, and home-manager, if it exists.
{
  inputs,
  config,
  config',
  lib,
  options,
  ...
}:
let
  inherit (lib.attrsets)
    attrNames
    attrValues
    filterAttrs
    genAttrs
    mapAttrs
    mapAttrs'
    nameValuePair
    ;
  inherit (lib.lists) filter intersectLists;
  inherit (lib.modules) mkMerge;
  inherit (lib.strings) optionalString removeSuffix;

  ageFiles =
    attrNames config'
    |> filter (
      v: config'.${v} ? publicKeys && !(config'.${v} ? dontLoad && config'.${v}.dontLoad == true)
    )
    |> (x: genAttrs x (v: config'.${v}));

  secrets = config'.system.${config.networking.hostName}.secrets or { };

  systemPublicKeys =
    secrets
    |> (filterAttrs (n: v: v ? key && v.key != null))
    |> mapAttrs (n: v: v.key)
    |> attrValues;
in
{
  options.age = { };

  imports = [
    inputs.agenix.nixosModules.default
  ];

  config = mkMerge [
    {
      # SSH private keys for the system side.
      age.identityPaths = lib.pipe secrets [
        (filterAttrs (n: v: v ? pkeyfile && v.pkeyfile != null))
        (mapAttrs (_: v: v.pkeyfile))
        attrValues
      ];

      age.secrets = lib.pipe ageFiles [
        (filterAttrs (n: v: (intersectLists systemPublicKeys v.publicKeys) != [ ]))
        (mapAttrs' (
          n: v: nameValuePair (removeSuffix ".age" n) { file = ./. + "../../../../Config/Secrets/${n}"; }
        ))
      ];
    }
    {
      secretspec = {
        files.${config.networking.hostName}."Config/Secrets/${config.networking.hostName}" =
          ./. + "../../../../Config/Secrets/${config.networking.hostName}";
        config = {
          project = {
            name = "System - ${config.networking.hostName}";
            revision = "1.0";
          };

          # Runs early in initrd, provide private key path correctly.
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
    }
    (lib.optionalAttrs (options ? home-manager.sharedModules) {
      home-manager.sharedModules = [
        (
          { config', ... }:
          {
            options.age = { };

            imports = [
              inputs.agenix.homeManagerModules.default
            ];

            config =
              let
                userSecrets = config'.secrets or { };

                publicKeys = lib.pipe userSecrets [
                  (filterAttrs (n: v: v ? key && v.key != null))
                  (mapAttrs (_: v: v.key))
                  attrValues
                ];
              in
              {
                age.identityPaths = lib.pipe userSecrets [
                  (filterAttrs (n: v: v ? pkeyfile && v.pkeyfile != null))
                  (mapAttrs (_: v: v.pkeyfile))
                  attrValues
                ];

                age.secrets = lib.pipe ageFiles [
                  (filterAttrs (n: v: (intersectLists v.publicKeys publicKeys) != [ ]))
                  (mapAttrs' (
                    n: v: nameValuePair (removeSuffix ".age" n) { file = ./. + "../../../../Config/Secrets/${n}"; }
                  ))
                ];
              };
          }
        )
      ];
    })
  ];
}
