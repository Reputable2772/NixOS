{
  programs.bash = {
    enable = true;
    bashrcExtra = ''

      # neofetch --config $HOME/Documents/Config/neofetch.conf
    '';
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons";
      ip = "ip -color";
      rm = "rmtrash";
      rmdir = "rmtrash";
    };
  };
}
