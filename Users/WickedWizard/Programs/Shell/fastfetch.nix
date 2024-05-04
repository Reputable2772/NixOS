{ pkgs, sources, ... }: {
  home.packages = with pkgs; [ fastfetch ];

  xdg.configFile.fastfetch = {
    enable = true;
    target = "fastfetch/config.jsonc";
    source = "${sources.fastfetch.src}/presets/examples/7.jsonc";
  };
}
