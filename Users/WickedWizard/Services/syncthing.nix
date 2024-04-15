{ osConfig, ... }: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--config=${osConfig.programs.config_dir.config_dir}/Syncthing"
      "--data=${osConfig.programs.config_dir.config_dir}/Syncthing/data"
      "--no-browser"
    ];
  };
}
