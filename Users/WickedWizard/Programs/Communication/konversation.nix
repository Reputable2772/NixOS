{ config, pkgs, ... }: {
  home.packages = with pkgs; [ konversation ];
}
