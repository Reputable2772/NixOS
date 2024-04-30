{ config, ... }: {
  age.secrets.cachix.file = ../../../Config/Cachix.age;

  services.cachix-agent = {
    enable = true;
    # File contains `CACHIX_AGENT_TOKEN=...`
    credentialsFile = config.age.secrets.cachix.path;
  };
}
