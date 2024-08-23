{ config, ... }: {
  # TODO: Declaratively configure rules.
  services.opensnitch.enable = false;

  home-manager.sharedModules = [
    { services.opensnitch-ui.enable = config.services.opensnitch.enable; }
  ];
}
