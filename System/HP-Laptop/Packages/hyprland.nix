{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    hyprlock.pam.enable = true;

    /**
      This is already set by Modules/System/hyprland.nix automatically.
      Moreover, it does not prioritize /run/wrappers/bin, causes further issues with
      systemd's user config.

      https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/hyprland.nix#L63-L68
     */
    systemd.setPath.enable = false;
  };
}
