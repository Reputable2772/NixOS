{ pkgs, inputs, ... }:
let
  inherit (pkgs) lib;
in
pkgs.devshell.mkShell {
  imports = [ "${inputs.devshell}/extra/git/hooks.nix" ];
  devshell = {
    name = "Development Shell for System Flake";
    packages = with pkgs; [
      coreutils
      curl
      jq
      hydra-check
      nixpkgs-fmt
      inputs.agenix.packages.${pkgs.system}.default
    ];
  };
  git.hooks = {
    enable = true;
    pre-commit.text = ''
      ${lib.getExe pkgs.nixVersions.latest} fmt
    '';
    commit-msg.text = ''
      ${lib.getExe pkgs.commitizen} check --allow-abort --commit-msg-file $1
    '';
  };
}
