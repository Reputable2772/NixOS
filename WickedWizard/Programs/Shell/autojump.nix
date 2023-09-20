{ pkgs, ... }: {
  home.packages = with pkgs; [ autojump ];

  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
