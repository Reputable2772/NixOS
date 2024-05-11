{ pkgs, ... }: {
  home.packages = with pkgs; [ keepassxc ];

  programs.autostart.autostartPackages = with pkgs; [ keepassxc ];
}
