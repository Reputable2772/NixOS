{ pkgs, ... }: {
  secretspec.config = {
    profiles.wickedwizard = {
      CACHIX_AUTH_TOKEN.description = "Token for pushing to caches.";
      CACHIX_ACTIVATE_TOKEN.description = "Token for activating cachix deployments.";
    };
    scopes.cachix.secrets = [
      "CACHIX_AUTH_TOKEN"
      "CACHIX_ACTIVATE_TOKEN"
    ];
  };

  home.packages = with pkgs; [ cachix ];
}
