{
  config,
  lib,
  inputs,
  ...
}:
let
  prefer-gnome = true;
  prefer-kde = !prefer-gnome;
  cfg =
    config.specialisation."desktop-environment-${
      if prefer-gnome then "gnome" else "kde"
    }".configuration;
in
/**
  Should (or) will work with the following logic.

  If Hyprland is enabled (on main), enable KDE in specialisation.
  If GNOME/KDE is enabled, enable Hyprland in specialisation.

  These values must be mkForce'd to avoid issues with pulling in default configs.
  Make sure any other values depending on these are defined in the respective config
  files. They will automatically be pulled in and evaluated, since specialisation.<name>.inheritParentConfig
  is set to true, by default.
*/
{
  specialisation."desktop-environment-${if prefer-gnome then "gnome" else "kde"}".configuration = {
    programs.hyprland.enable = lib.mkForce (!config.programs.hyprland.enable);

    # Enable when either GNOME/KDE is enabled.
    services.xserver.enable = lib.mkForce (
      cfg.services.desktopManager.plasma6.enable || cfg.services.xserver.desktopManager.gnome.enable
    );

    services.desktopManager.plasma6.enable = lib.mkForce (
      config.programs.hyprland.enable && prefer-kde
    );

    services.xserver.desktopManager.gnome.enable = lib.mkForce (
      config.programs.hyprland.enable && prefer-gnome
    );
  };

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  specialisation."desktop-environment-cosmic".configuration = {
    programs.hyprland.enable = lib.mkForce (!config.programs.hyprland.enable);

    imports = [
      inputs.nixos-cosmic.nixosModules.default
    ];

    services.desktopManager.cosmic.enable = false;
    services.displayManager.cosmic-greeter.enable = false;
  };
}
