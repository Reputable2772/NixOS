{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) strings types;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.options) mkEnableOption mkOption;

  cfg = config.programs.mimeApps;
  pythonHandler = ./mimetypes_parser.py;
  processedDefaultApplications = mapAttrs (
    # always take first element, if a list is provided.
    k: v: if strings.typeOf v == "list" then builtins.elemAt v 0 else v
  ) (lib.optionalAttrs cfg.useXdgMimeAppsDefaultApplications config.xdg.mimeApps.defaultApplications);
  priorityFiles = pkgs.writeText "mime-priority" (
    strings.concatMapAttrsStringSep "\n" (
      k: v: "${k}=${if strings.hasSuffix ".desktop" v then v else "${v}.desktop"}"
    ) (processedDefaultApplications // cfg.priority)
  );
in
{
  # Something like xdg.mimeApps.defaultApplicationPackages is insanely useful,
  # but not for flatpaks. Therefore, this custom module is needed.
  options.programs.mimeApps = {
    enable = mkEnableOption "enable automatic mimeApps handling." // {
      default = true;
    };
    packages = mkOption {
      default = [ ];
      type = types.listOf types.package;
      description = ''
        A list of packages whose MimeType needs to be handled.
      '';
    };
    flatpaks = mkOption {
      default = [ ];
      type = types.listOf types.str;
      description = ''
        Flatpaks whose MimeType needs to be handled.
      '';
    };
    priority = mkOption {
      default = { };
      type = types.attrsOf types.str;
      description = ''
        Resolves conflicts when two packages have the same mimetype.
        Failure to set when conflicts occur means that the first package
        to be eval'ed will have priority.
        Set programs.mimeApps.useXdgMimeAppsDefaultApplications = true to use
        xdg.mimeApps.defaultApplications in the priority list too.
      '';
    };
    useXdgMimeAppsDefaultApplications = mkEnableOption "usage of xdg.mimeapps.defaultApplications in the priority order of programs.mimeApps.priority";
  };

  config = lib.mkIf cfg.enable {
    xdg.mimeApps.enable = lib.mkForce false;
    home.activation.mimeappsList =
      lib.hm.dag.entryAfter
        [
          "flatpak-managed-install"
        ]
        ''
          tmp="$(mktemp)"
          [ -e "$tmp" ] && rm -rf "$tmp"
          touch "$tmp"

          for dir in ${strings.escapeShellArgs cfg.packages}; do
            if [ -d "$dir/share/applications" ]; then
              for file in "$dir/share/applications"/*.desktop; do
                [ -f "$file" ] || continue
                echo "$file" >> "$tmp"
              done
            fi
          done

          # This needs to be here, and cannot be moved to something like pkgs.runCommand,
          # due to this function doing runtime checking for desktop files after flatpaks and symlinks are installed
          for flatpak in ${strings.escapeShellArgs cfg.flatpaks}; do
            path="$HOME/.local/share/flatpak/exports/share/applications/$flatpak.desktop"
            if [ -f "$path" ]; then
              echo "$path" >> "$tmp"
            fi
          done

          rm -f "$HOME/.config/mimeapps.list"
          ${lib.getExe pkgs.python3} ${pythonHandler} ${priorityFiles} "$HOME/.config/mimeapps.list" "$tmp"
          rm -f "$tmp"
        '';
  };
}
