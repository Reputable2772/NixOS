{ config', ... }:
{
  services.flatpak = {
    packages = [ "md.obsidian.Obsidian" ];
    overrides = {
      "md.obsidian.Obsidian".Context.filesystems = [
        config'.dir.notes
        "!home"
      ];
    };
  };
}
