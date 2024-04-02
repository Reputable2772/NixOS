{ pkgs, ... }: {
  home.packages = with pkgs; [
    dnsutils
    eza
    neofetch
    rmtrash
  ];
}
