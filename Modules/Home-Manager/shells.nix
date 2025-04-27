{ config, lib, ... }:
with lib;
let
  cfg = config.programs.shells;
in
{
  options.programs.shells = {
    enable = mkEnableOption "Enable Shell (ZSH and Bash)";
    rcExtra = mkOption {
      default = "";
      type = types.lines;
      description = ''
        Extra commands that should be placed in {file}`~/.bashrc` or {file}`~/.zshrc`.
        Note that these commands will be run even in non-interactive shells.
      '';
    };
    sessionVariables = mkOption {
      default = { };
      type = types.attrs;
      example = {
        TEST = 30;
      };
      description = ''
        Environment variables that will be set for the shell session.
      '';
    };
    shellAliases = mkOption {
      default = { };
      type = types.attrsOf types.str;
      example = literalExpression ''
        {
          ll = "ls -l";
          ".." = "cd ..";
        }
      '';
      description = ''
        An attribute set that maps aliases (the top level attribute names in
        this option) to command strings or directly to build outputs.
      '';
    };
    enableCompletion = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to enable shell completion for all interactive shells.

        Note, if you use NixOS or nix-darwin and do not have Bash completion
        enabled in the system configuration, then make sure to add

        ```nix
          environment.pathsToLink = [ "/share/bash-completion" "/share/zsh-completion" ];
        ```

        to your system configuration to get completion for system packages.
        Note, the legacy {file}`/etc/bash_completion.d` path is
        not supported by Home Manager.
      '';
    };

    profileExtra = mkOption {
      default = "";
      type = types.lines;
      description = ''
        Extra commands that should be run when initializing a login
        shell.
      '';
    };
  };

  config =
    let
      base = {
        inherit (cfg)
          enable
          sessionVariables
          shellAliases
          enableCompletion
          profileExtra
          ;
      };
    in
    {
      programs.bash = {
        bashrcExtra = cfg.rcExtra;
      } // base;

      programs.zsh = {
        initContent = cfg.rcExtra;
      } // base;
    };
}
