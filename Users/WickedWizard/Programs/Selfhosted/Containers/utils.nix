{
  config,
  config',
  lib,
}:
rec {
  # Appends base part of volume path from config'.
  mapVolume =
    name: vol:
    lib.lists.map (
      v:
      (
        if config'.containers.${name} ? dir && config'.containers.${name}.dir != null then
          config'.containers.${name}.dir
        else
          "${config'.dir.containers}/${
            lib.strings.toUpper (lib.strings.substring 0 1 name)
            + lib.strings.substring 1 (lib.strings.stringLength name + 1) name
          }"
      )
      + "/"
      + v
    ) vol;

  appendEnv = name: {
    Environment = lib.optionals (
      config'.containers.${name} ? env && config'.containers.${name}.env != null
    ) (config'.containers.${name}.env);
    EnvironmentFile = lib.optionals (
      config'.containers.${name} ? envFiles && config'.containers.${name}.envFiles != null
    ) (lib.lists.map (n: config.age.secrets.${n}.path) config'.containers.${name}.envFiles);
  };

  defaults = {
    Service = {
      Restart = "always";
      TimeoutStartSec = 300;
    };
    /**
      Podman ships a file podman-user-wait-network-online.service located in /etc/systemd/user.
      It incorrectly assumes 'sh' in PATH and causes issues. virutalistaion.podman.package is modified
      at system-level to fix this.
    */
    Unit = {
      Wants = [ "network-online.target" ];
      After = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  containerDefaults =
    name: network:
    lib.recursiveUpdate {
      Container = {
        ContainerName = name;
        PodmanArgs = "--network-alias ${name} --user 0:0";
      };

      # We convert the raw network name to service name.
      Unit = {
        Requires = [ "${network}-network.service" ];
        After = [ "${network}-network.service" ];
      };
    } defaults;
}
