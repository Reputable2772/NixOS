{ config, sources, pkgs, ... }: {
  programs.hyprlock = {
    inherit (config.wayland.windowManager.hyprland) enable;
    # This is required since I'd like to use the source, but patch only a few lines.
    extraConfig = builtins.readFile "${pkgs.stdenv.mkDerivation {
        name = "hyprlock_catppuccin_patch";
        src = sources.hyprlock_catppuccin.src;
        patches = [ ./hyprlock.patch ];
        dontBuild = true;
        doCheck = false;
        dontConfigure = true;
        installPhase = ''
          mkdir -p $out
          cp -r * $out/
        '';
      }
    }/hyprlock.conf";
  };

  # Specifically this file, because https://github.com/catppuccin/hyprlock/blob/d5a6767000409334be8413f19bfd1cf5b6bb5cc6/hyprlock.conf#L1
  xdg.configFile."hypr/mocha.conf".source = "${sources.hyprland_catppuccin.src}/themes/mocha.conf";

  xdg.configFile."user.jpg".source = sources.wickedwizard_picture.src;
  xdg.configFile."lockscreen.png".source = sources.hyprlock_background.src;

  wayland.windowManager.hyprland.settings.bind = [
    "CTRL ALT, Delete, exec, hyprlock"
  ];
}
