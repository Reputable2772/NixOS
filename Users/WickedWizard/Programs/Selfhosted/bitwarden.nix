{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Bitwarden itself can act as a ssh agent,
  # making it infinitely more useful.
  home.packages = with pkgs; [
    bitwarden-desktop
    bitwarden-cli
  ];

  programs.autostart.packages = with pkgs; [ bitwarden ];

  services.ssh-agent.enable = lib.mkForce false;
  home.sessionVariables.SSH_AUTH_SOCK = "$\{HOME:-${config.home.homeDirectory}}/.bitwarden-ssh-agent.sock";
}
