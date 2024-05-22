{ config, ... }: {
  age.secrets.cachix.file = ../../../Config/cachix.age;

  services.cachix-agent = {
    enable = true;
    # File contains `CACHIX_AGENT_TOKEN=...`
    credentialsFile = config.age.secrets.cachix.path;
  };
}
