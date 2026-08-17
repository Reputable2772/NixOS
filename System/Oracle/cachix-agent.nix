{ config, ... }: {
  secretspec.config.profiles.oracle-server.CACHIX_AGENT_TOKEN.description =
    "Token to connect to Cachix Deploy as an agent";

  services.cachix-agent = {
    enable = true;
    credentialsFile = config.secretspec.secrets.profiles.oracle-server.CACHIX_AGENT_TOKEN.plainPath;
  };
}
