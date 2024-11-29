{ pkgs, sources, ... }:
{
  devshell = {
    name = "CI Shell";
    packages = with pkgs; [
      cachix
      jq
      coreutils
      (callPackage "${sources.nix-fast-build.src}/default.nix" { })
      nvfetcher
    ];
  };
}
