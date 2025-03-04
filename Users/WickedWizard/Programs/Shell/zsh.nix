{ sources, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    # initExtraFirst = ''
    #   source ~/.config/zsh-syntax-highlighting/theme.zsh
    # '';
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
  };

  # xdg.configFile."zsh-syntax-highlighting/theme.zsh".source = "${sources.catppuccin_zsh_syntax_highlighting.src}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
}
