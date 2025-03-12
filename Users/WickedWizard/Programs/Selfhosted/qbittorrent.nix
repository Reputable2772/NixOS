/**
  Don't bother trying qBittorrent in podman or any other
  type of containers.

  It simply seems to suck. It can't connect to trackers,
  can't seed, cannot detect port forwarding correctly and seems
  to have a lot of issues.

  Just use this instead. Declarative-ness be damned for this
  one module.
*/
{ pkgs, ... }:
{
  containers.caddy.services.qbittorrent = "host.containers.internal:63214";

  # Set ports, passwords, minimized window on startup and other configuration manually through web UI.
  home.packages = with pkgs; [ qbittorrent ];

  programs.autostart.packages = with pkgs; [ qbittorrent ];
}
