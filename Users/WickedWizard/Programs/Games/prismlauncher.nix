{ pkgs, ... }:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "prismlauncher";
    rev = "07e9c3ca0ff8eb7da9fa8b5329a9d2ceec707f24";
    sha256 = "sha256-/qUqF92e3kYkl59GUMMFRtRTzVgSp5tGPxnXLGeusys=";
  };
in
{
  home.packages = with pkgs; [ prismlauncher ];

  home.file.".local/share/PrismLauncher/themes/Mocha".source = "${catppuccin}/themes/Mocha";
}
