{ config, pkgs, ... }: {
  services.mysql = {
    enable = true;
    dataDir = "/var/db";
    user = "thisiscool";
    package = pkgs.mysql;
    # passwordFile = "./test.txt";
  };
}
