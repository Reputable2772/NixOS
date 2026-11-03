{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    uninstallUnmanaged = true;
    packages = [ "com.github.tchx84.Flatseal" ];
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

  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function()
            hl.exec_cmd("${pkgs.systemd}/bin/systemctl --user restart flatpak-managed-install.service")
          end
        '')
      ];
    }
  ];

  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
}
