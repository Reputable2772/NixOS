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

  system-config.environment.etc."polkit-1/actions/com.bitwarden.Bitwarden.policy".source =
    "${pkgs.bitwarden-desktop}/share/polkit-1/actions/com.bitwarden.Bitwarden.policy";

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "workspace 2, initialClass:(Bitwarden)"
  ];

  programs.autostart.packages = with pkgs; [ bitwarden-desktop ];

  services.ssh-agent.enable = lib.mkForce false;
  home.sessionVariables.SSH_AUTH_SOCK = "$\{HOME:-${config.home.homeDirectory}}/.bitwarden-ssh-agent.sock";
}
