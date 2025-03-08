{
  inputs,
  config',
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-mayhem.yaml";
    image = config'.wallpaper;
    polarity = "dark";
  };
}
