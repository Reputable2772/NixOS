{ config, pkgs, ... }: {
  home.packages = with pkgs; [ fluent-reader ];
}
