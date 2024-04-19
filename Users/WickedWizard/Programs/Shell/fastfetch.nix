{ pkgs, ... }: {
  home.packages = with pkgs; [ fastfetch ];

  xdg.configFile.fastfetch = {
    enable = true;
    target = "fastfetch/config.jsonc";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/fastfetch-cli/fastfetch/dev/presets/examples/7.jsonc";
      hash = "sha256-WTyW1j3oBAzTXmo2ostgDv2sFG7OPPuQPdCv9rKJ6t0=";
    };
  };
}
