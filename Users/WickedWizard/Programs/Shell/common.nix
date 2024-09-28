{ pkgs, ... }: {
  home.packages = with pkgs; [
    dnsutils
    eza
    rmtrash

    # Required by eza.
    nerdfonts
  ];

  # Required for eza
  fonts.fontconfig.enable = true;

  programs.shells = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons";
      ip = "ip -color";
      rm = "rmtrash";
      rmdir = "rmtrash";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
  };
}
