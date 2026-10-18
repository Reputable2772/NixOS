{ inputs, pkgs, ... }:
{
  devshell = {
    name = "CI Shell";
    packages = with pkgs; [
      cachix
      jq
      coreutils
      nvfetcher
      (writeShellApplication {
        name = "nix-build-all";
        text = ''
          ${pkgs.lixPackageSets.latest.nix-fast-build}/bin/nix-fast-build \
            --flake ${inputs.devour-flake}#packages.${pkgs.stdenv.hostPlatform.system}.default \
            --no-nom \
            --override-input nixpkgs ${inputs.nixpkgs} \
            --push-build-closure \
            "$@"
        '';
      })
    ];
  };

  imports = [
    ../Modules/Common/nvfetcher.nix
  ];

  commands = [
    {
      help = "Check Flakes";
      name = "check";
      command = "nix flake check";
    }
  ];
}
