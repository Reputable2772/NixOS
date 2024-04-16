{ osConfig, ... }: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--config=${osConfig.programs.config_dir.self_dir}/Config/Syncthing"
      "--data=${osConfig.programs.config_dir.self_dir}/Config/Syncthing/data"
    ];
  };
}
