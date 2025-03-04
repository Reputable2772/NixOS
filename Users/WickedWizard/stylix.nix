{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-mayhem.yaml";
  stylix.image = ../../Config/wallpaper.jpg;
  stylix.polarity = "dark";

  # Due to the autostart mdoule.
  xdg.configFile."autostart/stylix-activate-gnome.desktop".enable = lib.mkForce false;
  xdg.configFile."autostart/stylix-activate-kde.desktop".enable = lib.mkForce false;
  programs.autostart.files = [
    (pkgs.writeTextDir "share/applications/stylix-activate-gnome.desktop" (
      config.xdg.configFile."autostart/stylix-activate-gnome.desktop".text
    ))
    (pkgs.writeTextDir "share/applications/stylix-activate-kde.desktop" (
      config.xdg.configFile."autostart/stylix-activate-kde.desktop".text
    ))
  ];
}
