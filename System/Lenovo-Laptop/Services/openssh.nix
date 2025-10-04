{ lib, ... }:
{
  services.openssh.enable = lib.mkForce false;
}
