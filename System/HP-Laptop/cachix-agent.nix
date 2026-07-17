{ config, ... }: {
  services.cachix-agent = {
    enable = true;
    credentialsFile = config.age.secrets.hp-cachix-agent.path;
  };
}
