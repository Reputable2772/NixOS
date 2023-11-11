{ config, pkgs, ... }: {
  services.mysql = {
    enable = true;
    user = "wickedwizard";
    package = pkgs.mysql;
  };
}
