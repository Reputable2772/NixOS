{ config, config', lib }: {
  # Appends base part of volume path from config'.
  mapVolume = name: vol:
    lib.lists.map
      (v:
        (
          if config'.containers.${name} ? dir && config'.containers.${name}.dir != null
          then config'.containers.${name}.dir
          else "${config'.dir.containers}/${lib.strings.toUpper (lib.strings.substring 0 1 name) + lib.strings.substring 1 (lib.strings.stringLength name + 1) name}"
        )
        + "/" + v
      )
      vol;

  appendEnv = name: {
    Environment = lib.optionals
      (config'.containers.${name}.env ? name && config'.containers.${name}.env != null)
      (config'.containers.${name}.env);
    EnvironmentFile = lib.optionals
      (config'.containers.${name}.envFiles ? name && config'.containers.${name}.envFiles != null)
      (lib.lists.map (n: config.age.secrets.${n}.path) config'.containers.${name}.envFiles);
  };

  defaults = name: {
    Container = {
      ContainerName = name;
      PodmanArgs = "--network-alias ${name}";
    };

    Service = {
      Restart = "always";
      TimeoutStartSec = 300;
    };
    Unit = {
      Wants = [ "network-online.target" ];
      After = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
