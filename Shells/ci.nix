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
            --nix-eval-jobs ${pkgs.lixPackageSets.latest.nix-eval-jobs}/bin/nix-eval-jobs \
            --flake ${inputs.devour-flake}#packages.${pkgs.stdenv.hostPlatform.system}.default \
            --no-nom \
            --override-input nixpkgs ${inputs.nixpkgs} \
            "$@"
        '';
      })
    ];
  };

  imports = [
    ../Modules/Common/nvfetcher.nix
  ];

  # Needed for above.
  programs.nvfetcher.config.nix-fast-build = {
    src.git = "https://github.com/Mic92/nix-fast-build.git";
    fetch.github = "Mic92/nix-fast-build";
  };

  commands = [
    {
      help = "Check Flakes";
      name = "check";
      command = "nix flake check";
    }
  ];
}
