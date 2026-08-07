{ config, pkgs, ... }:
{
  programs.tmux.enable = true;
  programs.tmux.package = pkgs.tmux.override { withSystemd = false; };
  stylix.targets.tmux.enable = config.programs.tmux.enable;
}
