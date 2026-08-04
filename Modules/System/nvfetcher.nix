{
  config,
  lib,
  lib',
  ...
}:
let
  cfg = config;

  inherit (lib.attrsets) attrValues filterAttrs mapAttrs;
  inherit (lib.lists) foldl';
in
{
  options.programs.nvfetcher = { };

  imports = [
    ../Common/nvfetcher.nix
  ];

  config = {
    programs.nvfetcher.config =
      cfg.home-manager.users
      |> filterAttrs (n: v: v.programs.nvfetcher.enable)
      |> mapAttrs (n: v: v.programs.nvfetcher.config)
      |> attrValues
      |> foldl' (acc: elem: lib'.deepMerge acc elem) { };
  };
}
