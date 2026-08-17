{ config, ... }: {
  secretspec.config.profiles.hp-laptop.CACHIX_AGENT_TOKEN.description =
    "Token to connect to Cachix Deploy as an agent";

  services.cachix-agent = {
    enable = true;
    credentialsFile = config.secretspec.secrets.profiles.hp-laptop.CACHIX_AGENT_TOKEN.envPath;
  };
}
