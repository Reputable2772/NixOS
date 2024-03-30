{ pkgs, ... }: {
  home.packages = with pkgs; [ gnome.pomodoro ];
}
