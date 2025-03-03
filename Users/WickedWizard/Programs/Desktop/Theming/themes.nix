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

  qt = {
    enable = kde-disabled;
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig" = {
    enable = kde-disabled;
    text = ''
      [General]
      theme=KvGnomeDark
    '';
  };

  /**
    The Flatpak versions for the runtimes for Kvantum seems to
    be abandoned. The runtimes need to manually be built for Kvantum.

    TODO:
    https://github.com/flathub/org.kde.KStyle.Kvantum/pull/39
    Do using systemd services.
  */
  systemd.user.services."flatpak-managed-install".Service.ExecStartPost =
    let
      qt-68 = pkgs.fetchFromGitHub {
        owner = "SteavenGamerYT";
        repo = "org.kde.KStyle.Kvantum";
        rev = "refs/heads/patch-1";
        hash = "sha256-ZC8PQed1AWQNxpj0HCKKuCUAOKFscRQ0vw4iEsMmFng=";
      };
      qt-515-2408 = pkgs.fetchFromGitHub {
        owner = "SteavenGamerYT";
        repo = "org.kde.KStyle.Kvantum";
        rev = "refs/heads/patch-2";
        hash = "sha256-w8RywY8eDDR//DLJFv5Z5fR8e2KikUnIUm4rKBe5quY=";
      };
    in
    [
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
          ${pkgs.flatpak}/bin/flatpak --user override --filesystem=${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css
          ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-4.0/gtk.css)
          ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-4.0/settings.ini)
        ''
        + lib.optionalString (config.gtk.gtk3.extraCss != "") ''
          ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-3.0/gtk.css)
          ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.config/gtk-3.0/settings.ini)
        ''
      ))
    ]
    ++ lib.optional kde-disabled (
      pkgs.writeShellScript "kvantum-runtime-install" ''
        export PATH="$PATH:${pkgs.appstream}/bin"

        ${pkgs.flatpak-builder}/bin/flatpak-builder --force-clean --user --install --install-deps-from=flathub --repo=repo --install builddir ${qt-68}/org.kde.KStyle.Kvantum.json
        ${pkgs.flatpak-builder}/bin/flatpak-builder --force-clean --user --install --install-deps-from=flathub --repo=repo --install builddir ${qt-515-2408}/org.kde.KStyle.Kvantum.json
      ''
    );

  services.flatpak.overrides.global = {
    Environment.QT_STYLE_OVERRIDE = lib.mkIf kde-disabled "kvantum";
    Context.filesystems = [
      "xdg-config/gtk-4.0"
      "xdg-config/gtk-3.0"
    ] ++ lib.optional kde-disabled "xdg-config/Kvantum";
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
        lib.mkIf (config.gtk.theme ? name && config.gtk.theme ? package && builtins.pathExists path) (
          builtins.readFile path
        );
    };
  };
}
