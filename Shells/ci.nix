{ pkgs, inputs, sources }:
pkgs.mkShell {
  nativeBuildInputs = (with pkgs; [
    cachix
    jq
    coreutils
    (callPackage "${sources.nix-fast-build.src}/default.nix" { })
  ]) ++ [
    inputs.nvfetcher.packages.${pkgs.system}.default
  ];
}
