{ lib, ... }:
{
  # Conflicts with KDE Connect - https://wiki.archlinux.org/title/Avahi#KDE_Connect's_built_in_mDNS_conflicts
  services.avahi.enable = lib.mkForce false;
}
