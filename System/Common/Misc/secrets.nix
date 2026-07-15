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
  inherit (lib.strings) removeSuffix;

  ageFiles =
    attrNames config' |> filter (v: config'.${v} ? publicKeys) |> (x: genAttrs x (v: config'.${v}));

  systemPublicKeys =
    config'.system.${config.networking.hostName}.secrets
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
      age.identityPaths = lib.pipe config'.system.${config.networking.hostName}.secrets [
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
                publicKeys = lib.pipe (config'.secrets or { }) [
                  (filterAttrs (n: v: v ? key && v.key != null))
                  (mapAttrs (_: v: v.key))
                  attrValues
                ];
              in
              {
                age.identityPaths = lib.pipe (config'.secrets or { }) [
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
