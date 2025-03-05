{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-mayhem.yaml";
  stylix.image = ../../Config/wallpaper.jpg;
  stylix.polarity = "dark";
}
