{ sources, ... }: {
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        group_processes = true;
      };
    } // builtins.fromTOML (builtins.readFile "${sources.bottom_catppuccin.src}/themes/mocha.toml");
  };
}
