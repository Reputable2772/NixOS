{ config', ... }:
{
  services.flatpak = {
    packages = [ "tech.dongdongbh.mindwtr" ];
    overrides = {
      "tech.dongdongbh.mindwtr".Context.filesystems = [
        config'.dir.mindwtr
        config'.dir.notes
        "!home"
      ];
    };
  };
  programs.autostart.flatpaks = [ "tech.dongdongbh.mindwtr" ];
}
