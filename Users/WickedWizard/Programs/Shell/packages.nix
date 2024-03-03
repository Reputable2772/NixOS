{ pkgs, ... }: {
  home.packages = with pkgs; [
    bottom
    dnsutils
    eza
    neofetch
    rmtrash
  ];
}
