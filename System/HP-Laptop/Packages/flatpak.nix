{ inputs, ... }: {
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
  };

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];
}
