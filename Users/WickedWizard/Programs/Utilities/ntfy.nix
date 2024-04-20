{ pkgs, ... }: {
  home.packages = with pkgs; [ notify-client ];
}
