{ pkgs, ... }: {
  home.packages = with pkgs; [
    vesktop
  ];

  # programs.autostart.autostartPackages = with pkgs; [ vesktop ];
}
