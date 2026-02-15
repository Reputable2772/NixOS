{
  inputs,
  pkgs,
  sources,
  ...
}:
{
  devshell = {
    name = "CI Shell";
    packages = with pkgs; [
      cachix
      jq
      coreutils
      (callPackage "${sources.nix-fast-build.src}/default.nix" { })
      nvfetcher
      (writeShellApplication {
        name = "nix-build-all";
        text = ''
          nix-fast-build \
            --flake ${inputs.devour-flake}#packages.${pkgs.stdenv.hostPlatform.system}.default \
            --no-nom \
            "$@"
        '';
      })
    ];
  };
  commands = [
    {
      help = "Check Flakes";
      name = "check";
      command = "nix flake check";
    }
  ];
}
