{ pkgs, ... }: {
  home.packages = with pkgs; [ fastfetch ];

  xdg.configFile."fastfetch/config.jsonc".source = "${pkgs.fastfetch.src}/presets/examples/7.jsonc";
}
