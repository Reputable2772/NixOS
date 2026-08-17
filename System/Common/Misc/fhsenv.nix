{ pkgs, lib, ... }:
{
  # steam-run-free cannot run on arm systems (oracle-server)
  environment.systemPackages = lib.optional pkgs.stdenv.hostPlatform.isx86_64 pkgs.steam-run-free;
}
