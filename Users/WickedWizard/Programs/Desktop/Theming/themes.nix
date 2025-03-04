{
  config,
  pkgs,
  lib,
  ...
}:
let
  kde-disabled = !config.programs.plasma.enable;
in
{
  /**
    Only applicable if KDE is the default desktop environment.

    Transferred over to Flatpaks using Portals.
  */

  programs.plasma.workspace = {
    # Both theme and colorScheme need to be set to this value, not sure why. The packages for all these are automatically installed in case of Breeze.
    theme = "breeze-dark";
    colorScheme = "BreezeDark";
    iconTheme = "breeze-dark";
    cursor = {
      inherit (config.home.pointerCursor) size;
      theme = config.home.pointerCursor.name;
    };
  };

  # Configures Kvantum and qtct by itself.
  stylix.targets.qt = {
    enable = kde-disabled;
    platform = "qtct";
  };

  systemd.user.services."flatpak-managed-install".Service.ExecStartPost = [
    /**
      GTK4 - The flatpak theme requires HM Toplevel symlink, and all the other files referenced by it.
        The package/share/themes/<name>/gtk-4.0/gtk.css is automatically referenced by the toplevel HM gtk.css file
        and thus is required.

      GTK3 - The flatpak theme requires HM Toplevel symlink only.
        The package/share/themes/<name>/gtk-3.0/gtk.css is not automatically referenced by the toplevel HM gtk.css file,
        and needs to be manually symlinked by us.
    */
    (pkgs.writeShellScript "flatpak-gtk-themes" (
      lib.optionalString (config.gtk.theme ? name && config.gtk.theme ? package) ''
        ${pkgs.flatpak}/bin/flatpak --user override --filesystem=${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css:ro
        ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-4.0/gtk.css):ro
        ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-4.0/settings.ini):ro
      ''
      + lib.optionalString (config.gtk.gtk3.extraCss != "") ''
        ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-3.0/gtk.css):ro
        ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-3.0/settings.ini):ro
      ''
    ))
  ];
  /**
    The Flatpak versions for the runtimes for Kvantum seems to
    be abandoned. The runtimes need to manually be built for Kvantum.

    However, this is a tedious process with a lot of breakages.
    Installing kvantum and setting the environment variable does
    not work most of the time. Moreover, there seems to be no way to
    configure Qt5ct and Qt6ct within Flatpaks, leaving a lot to be desired.appstream

    Below are the remnants of the failed work.
  */
  # ++ (lib.optional kde-disabled (
  #   pkgs.writeShellScript "flatpak-kvantum-runtime" ''
  #     export PATH="$PATH:${pkgs.appstream}/bin"

  #     # Can't use fetchFromGitHub since that seems to rebuild the flatpak, even if there are no changes whatsoever.

  #     mkdir -p $HOME/.cache/kvantum-flatpak-runtime
  #     cd $HOME/.cache/kvantum-flatpak-runtime

  #     [ ! -d "Qt5" ] && git clone https://github.com/SteavenGamerYT/org.kde.KStyle.Kvantum.git Qt5 --branch patch-1 || (cd Qt5 && git pull)
  #     [ ! -d "Qt6" ] && git clone https://github.com/SteavenGamerYT/org.kde.KStyle.Kvantum.git Qt6 --branch patch-2 || (cd Qt6 && git pull)

  #     cd Qt5
  #     ${pkgs.flatpak-builder}/bin/flatpak-builder --force-clean --user --skip-if-unchanged --install --install-deps-from=flathub --repo=repo --install builddir org.kde.KStyle.Kvantum.json
  #     cd ..

  #     cd Qt6
  #     ${pkgs.flatpak-builder}/bin/flatpak-builder --force-clean --user --skip-if-unchanged --install --install-deps-from=flathub --repo=repo --install builddir org.kde.KStyle.Kvantum.json
  #     cd ..
  #   ''
  # ))
  # ++ lib.optional kde-disabled (
  #   pkgs.writeShellScript "flatpak-kvantum-symlink" ''
  #     ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/Kvantum/kvantum.kvconfig):ro

  #     # Dynamically read theme name from Kvantum config.
  #     theme_name=$(${pkgs.jc}/bin/jc --ini < $HOME/.config/Kvantum/kvantum.kvconfig | ${pkgs.jq}/bin/jq '.General.theme' | ${pkgs.coreutils}/bin/tr -d '"')
  #     ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink "$HOME/.config/Kvantum/$theme_name"):ro
  #   ''
  # );

  # qt5ct and qt6ct don't work with Flatpaks.
  services.flatpak.overrides.global = {
    # Environment.QT_STYLE_OVERRIDE = lib.mkIf kde-disabled "kvantum";
    Context.filesystems = [
      "xdg-config/gtk-4.0"
      "xdg-config/gtk-3.0"
    ];
    # ++ lib.optional kde-disabled "xdg-config/Kvantum";
  };

  stylix.targets.gtk = {
    enable = true;
    # Look above for custom flatpak support code.
    flatpakSupport.enable = false;
  };

  /**
    Applicable regardless of whether GNOME
    is the default DE or not.

    Should be transferred over to flatpaks using Portals.
  */
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  # GTK4 and GTK3 themes
  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      # Does the same thing as GTK4, since HM doesn't do it automatically.
      extraCss =
        let
          path = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk.css";
        in
        lib.mkIf (
          !config.stylix.targets.gtk.enable
          && config.gtk.theme ? name
          && config.gtk.theme ? package
          && builtins.pathExists path
        ) (builtins.readFile path);
    };
  };
}
