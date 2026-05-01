{ config', ... }:
{
  programs.nh = {
    enable = true;
    flake = config'.flake.dir.self;
  };
}
