{ pkgs, ... }: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  home.packages = with pkgs; [ goverlay ];
}
