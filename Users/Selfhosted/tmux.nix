{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.sysstat;
        extraConfig = "set -g status-right \"#{sysstat_cpu} | #{sysstat_mem} | #{sysstat_swap} | #{sysstat_loadavg} | #[fg=cyan]#(echo $USER)#[default]@#H\"";
      }
    ];
  };
}
