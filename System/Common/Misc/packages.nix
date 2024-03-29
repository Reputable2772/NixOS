{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gitFull
    curl
    nano
  ];
}
