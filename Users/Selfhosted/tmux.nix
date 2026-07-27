{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    # NixOS/nixpkgs#546302
    package = pkgs.tmux.override { withSystemd = false; };
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.sysstat;
        extraConfig = "set -g status-right \"#{sysstat_cpu} | #{sysstat_mem} | #{sysstat_swap} | #{sysstat_loadavg} | #[fg=cyan]#(echo $USER)#[default]@#H\"";
      }
    ];
  };
}
