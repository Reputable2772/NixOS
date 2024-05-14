{ pkgs, ... }: {
  home.packages = with pkgs; [
    vesktop
  ];

  # programs.autostart.packages = with pkgs; [ vesktop ];
}
