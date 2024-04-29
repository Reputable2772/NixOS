{ config, inputs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  # SSH private keys for the system side.
  age.identityPaths = [
    "${config.programs.config_dir.self_dir}/Config/SSH/Encryption/Encryption"
  ];
}
