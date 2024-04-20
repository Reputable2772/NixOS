{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    curl
    nano
  ];
}
