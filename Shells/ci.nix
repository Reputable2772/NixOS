{ pkgs, sources }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cachix
    jq
    coreutils
    (callPackage "${sources.nix-fast-build.src}/default.nix" { })
    nvfetcher
  ];
}
