{
  config',
  lib,
  ...
}:
{
  services.flatpak.packages = [ "io.gitlab.librewolf-community" ];
  services.flatpak.overrides."io.gitlab.librewolf-community" =
    lib.optionalAttrs (config'.dir ? browsers && config'.dir.browsers != null)
      {
        Context.filesystems = "${config'.dir.browsers}/Librewolf";
      };

  home.file.".var/app/io.gitlab.librewolf-community/profiles.ini".text = ''
    [Profile0]
    Name=Default
    IsRelative=0
    ${lib.optionals (
      config'.dir ? browsers && config'.dir.browsers != null
    ) "Path=${config'.dir.browsers}/Librewolf"}

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  programs.autostart.flatpaks = [ "io.gitlab.librewolf-community" ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, B, exec, io.gitlab.librewolf-community"
    ];
    windowrule = [
      "match:initial_class (librewolf), workspace 3"
    ];
  };
}
