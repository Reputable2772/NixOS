{ ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      export RCLONE_CONFIG=$HOME/Documents/Config/rclone.conf
      export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"

      neofetch --config $HOME/Documents/Config/neofetch.conf
    '';
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons";
      ip = "ip -color";
      rm = "rmtrash";
      rmdir = "rmtrash";
    };
  };
}
