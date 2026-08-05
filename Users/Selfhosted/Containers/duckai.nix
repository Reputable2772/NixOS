{ sources, ... }: {
  containers.caddy.services.duckai = "duckai:3000";

  programs.nvfetcher.config.duckai = {
    fetch.git = "https://github.com/cobbdzon/duckai.git";
    src.git = "https://github.com/cobbdzon/duckai.git";
  };

  programs.quadlets.quadlets."duckai.container" = {
    __options.networkNameAlias = false;
    Container = {
      ContainerName = "duckai";
      Image = "duckai-image.build";
      Network = "systemd-caddy.network";
      Environment = [
        "PORT=3000"
        "HOST=0.0.0.0"
      ];
    };
  };

  programs.quadlets.quadlets."duckai-image.build".Build = {
    ImageTag = "localhost/duckai";
    SetWorkingDirectory = sources.duckai.src;
  };
}
