{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
  };
}
