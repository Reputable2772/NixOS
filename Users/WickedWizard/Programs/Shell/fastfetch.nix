{ pkgs, ... }: {
  home.packages = with pkgs; [ fastfetch ];

  xdg.configFile.fastfetch = {
    enable = true;
    target = "fastfetch/config.jsonc";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/fastfetch-cli/fastfetch/dev/presets/examples/7.jsonc";
      hash = "sha256-mJWKbqN0CwSz21d6RHATogMuQxKFmDD3PMD33JiWYL8=";
    };
  };
}
