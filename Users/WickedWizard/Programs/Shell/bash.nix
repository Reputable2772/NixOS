{ osConfig, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # neofetch --config ${osConfig.programs.config_dir.config_dir}/neofetch.conf
    '';
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons";
      ip = "ip -color";
      rm = "rmtrash";
      rmdir = "rmtrash";
    };
  };
}
