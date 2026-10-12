{ config, ... }: {
  secretspec.config.profiles.astra-1.CACHIX_AGENT_TOKEN.description =
    "Token to connect to Cachix Deploy as an agent";

  services.cachix-agent = {
    enable = true;
    credentialsFile = config.secretspec.secrets.profiles.astra-1.CACHIX_AGENT_TOKEN.envPath;
  };
}
