{ pkgs, ... }: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      fps_metrics = 0.01;
    };
  };

  home.packages = with pkgs; [ goverlay ];
}
