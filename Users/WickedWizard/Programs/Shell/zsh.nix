{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      # neofetch --config $HOME/Documents/Config/neofetch.conf
    '';
    syntaxHighlighting = {
      enable = true;
    };
    sessionVariables = {
      RCLONE_CONFIG = "$HOME/Documents/Config/rclone.conf";
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    };
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons";
      ip = "ip -color";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "rm" = "rmtrash";
      "rmdir" = "rmtrash";
    };
  };
}
