{ config, ... }:
{
  programs.tmux.enable = true;
  stylix.targets.tmux.enable = config.programs.tmux.enable;
}
