{ pkgs, ... }: {
  home.packages = with pkgs; [
    dnsutils
    eza
    rmtrash
  ];

  programs.shells = {
    enable = true;
    enableCompletion = true;
    rcExtra = ''
      fastfetch
    '';
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
