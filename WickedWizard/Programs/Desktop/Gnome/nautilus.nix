{ config, pkgs, ... }: {
  home.packages = with pkgs; [ nautilus-open-any-terminal ];
}
