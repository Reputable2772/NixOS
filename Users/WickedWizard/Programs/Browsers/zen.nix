{ config', lib, ... }:
{
  services.flatpak = {
    packages = [ "app.zen_browser.zen" ];
    overrides."app.zen_browser.zen" =
      lib.optionalAttrs (config'.dir ? browsers && config'.dir.browsers != null)
        {
          Context.filesystems = "${config'.dir.browsers}/Zen";
        };
  };

  programs.autostart.flatpaks = [ "app.zen_browser.zen" ];

  # Zen, for some reason, requires this file to be writable.
  # home.file.".var/app/app.zen_browser.zen/.zen/profiles.ini".text = ''
  #   [Profile0]
  #   Name=Default
  #   IsRelative=0
  #   Default=1
  #   ${lib.optionalString (
  #     config'.dir ? browsers && config'.dir.browsers != null
  #   ) "Path=${config'.dir.browsers}/Zen/"}
  # '';
}
