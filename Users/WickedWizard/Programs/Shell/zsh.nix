{ osConfig, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
    syntaxHighlighting = {
      enable = true;
    };
    sessionVariables = {
      RCLONE_CONFIG = "${osConfig.programs.config_dir.config_dir}/rclone.conf";
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
