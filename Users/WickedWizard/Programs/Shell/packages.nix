{ pkgs, ... }: {
  home.packages = with pkgs; [
    dnsutils
    eza
    rmtrash
  ];
}
