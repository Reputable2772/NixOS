{ inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  programs.secrets = {
    secrets = {
      git = {
        authorization = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAKg52CA11/TshMFkN689IYepPlIDJZQOA7cMzoe7PU wickedwizard@hp-laptop";
        signing = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s075auCly0MMeG91zc20jjzzp4vm0cz0V8SBGNNpR wickedwizard@hp-laptop";
      };
    };
  };
}
