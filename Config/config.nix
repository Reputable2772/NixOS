/**
  All the config goes here. System config, per-user config, overall flake config, etc.
  The aim is to replace the old config modules.

  If you don't want something, or want to disable the module, set the value to null.

  All the keys are added to ssh-agent using KeePassXC.
*/

rec {
  flake = {
    dir = rec {
      # Internal Variable
      base = "/home/wickedwizard/Documents";
      # Location where undeclarative system config is stored, so that one folder can be moved about systems. This directory needs to be gitignored.
      config = "${self}/Config";
      # Working directory of the flake.nix file
      self = "${base}/NixOS";
    };
  };

  system = {
    secrets = {
      /**
        The SSH Keys for encrypting system related secrets.
        This key should not have password, since age(nix) doesn't support using ssh-agent.
        If you do set a password, it should be entered everytime the system is booted up,
        or everytime you switch configurations.

        Note: If you set a password for this, you most probably cannot use any
        deployment tools like cachix-deploy, colmena, etc.
       */
      encryption = {
        pkeyfile = "${flake.dir.config}/SSH/Encryption/Encryption";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN618WSaf14crbHvqgDdhAqkgjz6tmyjKwL00viq5CQd wickedwizard@hp-laptop";
      };
    };
  };

  users = {
    wickedwizard = {
      config = {
        dir = rec {
          # Internal variable, should not be used
          base = "/home/wickedwizard/Documents";
          # Where to store the browser profiles, for easily moving it about.
          browsers = "${base}/Browsers";
          # Where to store generic undeclarative user config. Should be gitignored
          config = "${flake.dir.self}/Config";
        };
        git = {
          # The username and email to set for Git.
          username = "Reputable2722";
          email = "153411261+Reputable2772@users.noreply.github.com";
        };
      };
      secrets = {
        git = {
          # The SSH Key that is used for authentication by Git
          authentication = {
            pkeyfile = "${users.wickedwizard.config.dir.config}/SSH/Authentication/Authentication";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAKg52CA11/TshMFkN689IYepPlIDJZQOA7cMzoe7PU wickedwizard@hp-laptop";
          };
          # The SSH Key that is used for signing by Git
          signing = {
            pkeyfile = "${users.wickedwizard.config.dir.config}/SSH/Signing/Signing";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s075auCly0MMeG91zc20jjzzp4vm0cz0V8SBGNNpR wickedwizard@hp-laptop";
          };
        };
      };
    };
  };

  # Agenix config
  "Cachix.age".publicKeys = [ system.secrets.encryption.key ];
}
