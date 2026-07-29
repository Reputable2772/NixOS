{
  programs.home-manager.enable = true;

  imports = [
    ./bottom.nix
    ./tmux.nix
  ];

  system-config.firewall.allowedTCPPorts = [ 11434 ];

  programs.quadlets = {
    enable = true;
    quadlets = {
      # "minecraft.container" = {
      #   __options.networkNameAlias = false;
      #   Container = {
      #     ContainerName = "minecraft";
      #     Image = "docker.io/itzg/minecraft-server";
      #     PublishPort = [
      #       "12365:25565"
      #     ];
      #     Volume = [
      #       "data:/data"
      #     ];
      #   };
      # };

      "ddns-updater.container" = {
        __options.networkNameAlias = false;
        Container = {
          ContainerName = "ddns-updater";
          Image = "docker.io/favonia/cloudflare-ddns:latest";
          Network = "host";
          User = "1000:1000";

          ReadOnly = true;
          SecurityLabelDisable = true;
          NoNewPrivileges = true;
          DropCapability = "all";
        };
      };
    };
  };
}
