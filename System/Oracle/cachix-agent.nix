{ config, ... }: {
  services.cachix-agent = {
    enable = true;
    credentialsFile = config.age.secrets.oracle-cachix-agent.path;
  };
}
