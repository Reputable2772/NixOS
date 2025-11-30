{
  inputs,
  config',
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-mayhem.yaml";
    image = config'.wallpaper;
    polarity = "dark";

    # Since stylix isn't on 26.05 yet.
    enableReleaseChecks = false;
  };
}
