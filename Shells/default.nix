{ pkgs, inputs, ... }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    coreutils
    curl
    jq
    hydra-check
    nixpkgs-fmt
    inputs.agenix.packages.${pkgs.system}.default
  ];
  shellHook = pkgs.lib.strings.concatStrings [
    # Fixes https://github.com/direnv/direnv/issues/73
    # "export_alias codium 'codium --profile Nix $@'"
    "\n"
    (inputs.pre-commit-hooks.lib.${pkgs.system}.run {
      src = ../.;
      hooks = {
        nixpkgs-fmt.enable = true;
        commitizen.enable = true;
      };
    }).shellHook
  ];
}
