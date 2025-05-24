{ inputs, ... }:
{
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    packages = [ "com.github.tchx84.Flatseal" ];
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
  };

  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
}
