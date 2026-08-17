/**
  All the config goes here. System config, per-user config, overall flake config, etc.
  The aim is to replace the old config modules.

  If you don't want something, or want to disable the module, set the value to null.

  All the keys are added to ssh-agent using KeePassXC.
*/
{
  _home ? { },
}:
rec {
  flake = {
    dir = rec {
      # Internal Variable
      base = "/home/wickedwizard/Documents/Coding/Nix";
      # Location where undeclarative system config is stored, so that one folder can be moved about systems. This directory needs to be gitignored.
      config = "${self}/Config";
      # Working directory of the flake.nix file
      self = "${base}/NixOS";
    };
  };

  system = {
    timezone = "Asia/Kolkata";
    locale = "en_IN";
    lenovo-laptop = {
      # The name of network interface, that has an IPv4 address
      # and is connected to the intenet, behind CGNAT
      publicNetworkInterface = "wlp0s20f3";
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
          # /persist because of impermanence nix-community/impermanence#301
          pkeyfile = "/persist/etc/ssh/Lenovo-Encryption";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN618WSaf14crbHvqgDdhAqkgjz6tmyjKwL00viq5CQd wickedwizard@lenovo-laptop";
        };
      };

      mounts = {
        # Need to have a corresponding age file with the object name, if you want to provide authentication.
        # bitlocker = {
        #   windows = {
        #     source = "/dev/nvme0n1p4";
        #     mountpoint = "/mnt/Windows";
        #     authentication = true;
        #     fsType = "ntfs";
        #     nofail = true;
        #   };
        # };
      };
    };

    hp-laptop = {
      secrets = {
        encryption = {
          pkeyfile = "/etc/ssh/HP-Encryption";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9rLYwb+3DofPSPGlif3FvrIb2V/ujfn3u7d/YmfU7s";
        };
      };
    };

    oracle-server = {
      secrets = {
        encryption = {
          pkeyfile = "/etc/ssh/Oracle-Encryption";
          key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPuAW9dlf0Q/siS8iCyfLqgBnc/dRF+FXYOjDFLkVJlsXFRSUNN44oYFGDG9KeMBd1T2U/OZ4APGVFGASP0rQuQyp6FL3M7HIl2hTH9ABvjUKd02gy94OysGn/wh5WGaroCJWHQR2nGD+VaoYA6vq8DbgHUEmJaP1V165Xxc2lOrlQ+0or7BmfXY6VmQxFPMj0bfYAly/PFopvz463RG5bV2e/H4WrhkjHP+hrposb+IwGV6JuFLE9U0njSwbADlLJb+Vuv1o1Tn4TNxRDBI/vrbw4k2676nOFXR+I03YQWHAKcHgn6w0vzQAX43r7L4f/jaPY+fBIakf8rH49Mnmwrkif8vL9cci9Jz6HHlJq99lJSQLQuObJlGD4FzIKtgsuQViZh3QyIt9Dr5Q4ksE+I0fT8GPqbUQb7M96t4mKex98//gdS6KIhbAvQwXcbKiTK/ap4uHR+mB24dHVoJndLpxAOaHZ0Ovrrwb0DJXTQ561KQEM2HmKe95PIvMCZzM=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPuAW9dlf0Q/siS8iCyfLqgBnc/dRF+FXYOjDFLkVJlsXFRSUNN44oYFGDG9KeMBd1T2U/OZ4APGVFGASP0rQuQyp6FL3M7HIl2hTH9ABvjUKd02gy94OysGn/wh5WGaroCJWHQR2nGD+VaoYA6vq8DbgHUEmJaP1V165Xxc2lOrlQ+0or7BmfXY6VmQxFPMj0bfYAly/PFopvz463RG5bV2e/H4WrhkjHP+hrposb+IwGV6JuFLE9U0njSwbADlLJb+Vuv1o1Tn4TNxRDBI/vrbw4k2676nOFXR+I03YQWHAKcHgn6w0vzQAX43r7L4f/jaPY+fBIakf8rH49Mnmwrkif8vL9cci9Jz6HHlJq99lJSQLQuObJlGD4FzIKtgsuQViZh3QyIt9Dr5Q4ksE+I0fT8GPqbUQb7M96t4mKex98//gdS6KIhbAvQwXcbKiTK/ap4uHR+mB24dHVoJndLpxAOaHZ0Ovrrwb0DJXTQ561KQEM2HmKe95PIvMCZzM= wickedwizard@lenovo-laptop";
        };
      };
    };

    rescue = { };
  };

  users = rec {
    wickedwizard = rec {
      home = _home.wickedwizard or "";
      # Copy from above, used in DuckDNS updating.
      publicNetworkInterface = system.lenovo-laptop.publicNetworkInterface;
      wallpaper = ./wallpaper.jpg;
      /**
        There needs to be a corresponding age file, with the name
        `user-backup.age`, use user encryption keys only.
      */
      backup = rec {
        # Internal variables
        base = "${home}/Documents";

        repository = "${home}/Backup";
        paths = {
          include = map (x: "${base}/${x}") [
            "Android"
            "Applications"
            "Books"
            "Browsers"
            "Coding"
            "Config"
            # Games/Linux/Minecraft now points to a symlink for Games/Minecraft
            "Games/Minecraft"
            "Games/Saves"
            "Important-Files"
            "Study-Materials"
            "Misc"
            "Notes"
            "MindWTR"
            "test"
          ];
          exclude = [ ];
        };
        # Ludusavi is a backup tool for Games.
        ludusavi = import ./ludusavi.nix {
          inherit home;
          games = "${base}/Games";
        };
      };

      # Drives or gocryptfs locations to mount.
      mounts = {
        /**
          By default, authentication for these gocryptfs folders is assumed to be false.
          If authentication is necessary, set `authentication = true`.

          A corresponding secret is added to secretspec automatically.
          Just `nix build` secretspec config file, and set the secret with
          the same name as the attrset name for each mount.
        */
        gocryptfs = {
          important_files = {
            source = "${dir.base}/Important-Files";
            mountpoint = "${dir.base}/../Mounted/Important-Files";
            authentication = true;
          };
        };
      };
      dir = rec {
        # Internal variable, should not be used
        base = "${home}/Documents";
        # Where to store the browser profiles, for easily moving it about.
        browsers = "${base}/Browsers";
        # Where to store generic undeclarative user config. Should be gitignored
        config = "${flake.dir.self}/Config";
        # Where to store all container data. Set to null to disable containers.
        containers = "${home}/Containers";
        # Where Obsidian Notes are stored.
        notes = "${base}/Notes";
        # Where MindWTR is stored.
        mindwtr = "${base}/MindWTR";
      };
      git = {
        # The username and email to set for Git.
        username = "Reputable2722";
        email = "153411261+Reputable2772@users.noreply.github.com";
        secrets = {
          # The SSH Key that is used for authentication by Git
          authentication = {
            pkeyfile = "${users.wickedwizard.dir.config}/SSH/Git/Authentication/Authentication";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAKg52CA11/TshMFkN689IYepPlIDJZQOA7cMzoe7PU wickedwizard@lenovo-laptop";
          };
          # The SSH Key that is used for signing by Git
          signing = {
            pkeyfile = "${users.wickedwizard.dir.config}/SSH/Git/Signing/Signing";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s075auCly0MMeG91zc20jjzzp4vm0cz0V8SBGNNpR wickedwizard@lenovo-laptop";
          };
        };
      };
      secrets = {
        # Passwords should not be set for this key, look above.
        encryption = {
          pkeyfile = "${flake.dir.config}/SSH/User-Encryption/WickedWizard";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsy1bfWG4U17PEZAc4KKVFDxIRtC4fyA8lPCG/f8/ZK wickedwizard@lenovo-laptop";
        };
        # The age file that is to be used by rclone. Set to null to disable.
        rcloneAgeFile = "rclone";
      };
      containers = rec {
        # Not a container, refer to Users/WickedWizard/Programs/Selfhosted/backup.nix.
        # Can contain the path with docker mount path, or without. Doesn't matter.
        backup = {
          blacklistedContainers = [
            "ollama.container"
          ];
          blacklistedPaths = [
            # lidarr.custom.downloadPath
            # lidarr.custom.music.libraryPath
          ]
          ++ syncthing.custom.folders;
          location = "${dir.base}/Applications/Containers-Backup";
          pwdFile = "containers-backup-pwd";
        };
        caddy = {
          # Setting it to null or omitting it will use the default directory
          dir = null;
          # A list of all the agenix file names to be used, without the age suffix.
          # Content of each agenix file is mentioned below.
          envFiles = [ ];
          # Environment variables
          env = [ "LOG_FILE=/data/access.log" ];
        };
        # baikal = {
        #   dir = null;
        #   envFiles = null;
        #   env = null;
        # };
        vaultwarden = {
          dir = null;
          envFiles = [ ];
          env = [
            "WEBSOCKET_ENABLE=true"
            "ROCKET_PORT=80"
            "PUSH_ENABLED=true"
            "LOG_FILE=/data/vaultwarden.log"
            "EXPERIMENTAL_CLIENT_FEATURE_FLAGS=ssh-key-vault-item,ssh-agent-v2,pm-26340-linux-biometrics-v2,simple-login-self-host-alias"
          ];
        };
        syncthing = {
          dir = null;
          envFiles = null;
          env = [
            "TZ=${system.timezone}"
            "PUID=0"
            "PGID=0"
          ];
          # All custom config that a container requires is put here.
          # Applicable on a per-container basis only.
          custom = {
            # Internal and external mapping of folders for Syncthing
            folders =
              map (x: dir.base + "/" + x) [
                "Android/Backups:/android-backups"
                "Android/Tasker:/android-tasker"
                "Books:/books"
                "Important-Files:/important-files"
                # "Joplin:/joplin"
                "Study-Materials:/study-materials"
                "Notes:/notes"
                "MindWTR:/mindwtr"
              ]
              ++ [
                "${backup.location}:/containers-backup"
                "${wickedwizard.backup.repository}:/backup"
              ];
          };
        };
        linkding = {
          dir = null;
          envFiles = null;
          env = null;
        };
        ente_museum = {
          dir = "${dir.containers}/Ente/museum";
          envFiles = [ ];
          env = [ "ENTE_CREDENTIALS_FILE=/credentials.yaml" ];
        };
        ente_postgres = {
          dir = "${dir.containers}/Ente/postgres";
          envFiles = [ ];
          env = null;
        };
        # ente_socat = {
        #   dir = "${dir.containers}/Ente/socat";
        #   envFiles = null;
        #   env = null;
        # };
        # ente_minio = {
        #   dir = "${dir.containers}/Ente/minio";
        #   envFiles = [ "ente" ];
        #   env = null;
        # };
        # ente_minio-provision = {
        #   dir = "${dir.containers}/Ente/minio-provision";
        #   env = null;
        #   envFiles = null;
        # };
        wud = {
          dir = null;
          envFiles = [ ];
          env = [ "TZ=${system.timezone}" ];
        };
        ollama = {
          dir = null;
          envFiles = null;
          env = [
            # "OLLAMA_VULKAN=1"
            "OLLAMA_NUM_GPU=0"
            "OLLAMA_INTEL_GPU=false"
            "OLLAMA_KEEP_ALIVE=10m"
            "OLLAMA_LOAD_TIMEOUT=15m"
          ];
        };
        podman-socket-proxy = {
          dir = null;
          env = null;
          envFiles = null;
        };
        n8n = {
          dir = null;
          env = [
            "N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true"
            "N8N_PROTOCOL=https"
            "NODE_ENV=production"
            "GENERIC_TIMEZONE=${system.timezone}"
            "TZ=${system.timezone}"
            "N8N_RESTRICT_FILE_ACCESS_TO=/files/"
            # Since I'm using reverse proxy setup with N8N_HOST env var.
            "N8N_PROXY_HOPS=1"
          ];
          envFiles = [ ];
          custom.volumeMounts = [
            "${dir.notes}:/files/obsidian"
          ];
        };
        n8n-runner = {
          dir = null;
          env = null;
          envFiles = [ ];
        };
        radicale = {
          dir = null;
          env = [ "TZ=${system.timezone}" ];
          envFiles = null;
        };
        crowdsec = {
          dir = null;
          env = null;
          envFiles = null;
        };
      };
    };
    guest = { };
    maintenance = rec {
      home = _home.maintenance or "";
      flakeDir = "${home}/NixOS";
      secrets = rec {
        encryption = {
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQpS9zfSJ6IWbXOs4ndPMJp93yQVfYahKfsUbRosFbC";
          pkeyfile = "${flakeDir}/Config/SSH/User-Encryption/Maintenance";
        };
        ssh = encryption;
      };
      dir.containers = "${home}/Containers";
      containers = {
        minecraft = {
          dir = null;
          envFiles = null;
          env = [
            "EULA=TRUE"
            "TYPE=FABRIC"
            "MEMORY=5G"
            "TZ=Asia/Kolkata"
            "ONLINE_MODE=FALSE"
            "ENFORCE_SECURE_PROFILE=FALSE"
            "VERSION_FROM_MODRINTH_PROJECTS=FALSE"
            "VERSION=26.1"
            # fabrictailor,easyauth,ledge have not been released for 26.1
            "MODRINTH_PROJECTS=fabric-api,fabric-language-kotlin,lithium,ferrite-core"
            "OPS=wickedwizard3588"
          ];
        };
      };
    };
    selfhosted = rec {
      home = _home.selfhosted or "";
      flakeDir = "${home}/NixOS";
      secrets = rec {
        encryption = {
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGj9+cqVLVe9jElkvjx0UZ16HXVzdr7VE80pFtwzvJac";
          pkeyfile = "${flakeDir}/Config/SSH/User-Encryption/Selfhosted";
        };
        ssh = encryption;
      };
      dir.containers = "/mnt/selfhosted/Containers";
      containers = {
        ollama = {
          dir = null;
          envFiles = null;
          env = [
            "GGML_VULKAN=1"
            "OLLAMA_KEEP_ALIVE=10m"
            "OLLAMA_IGPU_ENABLE=1"
            "OLLAMA_LOAD_TIMEOUT=15m"
          ];
        };
        freellmapi = {
          dir = null;
          envFiles = [ ];
          env = [
            "NODE_ENV=production"
            "PORT=3001"
            "FALLBACK_TIME_BUDGET_MS=0"
          ];
        };
        caddy = {
          dir = null;
          envFiles = [
            "selfhosted-domains"
            "oracle-crowdsec-caddy-bouncer"
          ];
          env = null;
        };
        duckai = {
          dir = null;
          envFiles = null;
          env = null;
        };
        crowdsec = {
          dir = null;
          env = null;
          envFiles = null;
        };
      };
    };
    remotebuild = {
      secrets = {
        inherit (selfhosted.secrets) ssh;
      };
    };
  };

  /**
    Secrets are entirely handled by secretspec.
    Agenix is purely used for easier viewing
    and bulk changes of secrets to the age file
    manually.

    As a side effect, these files are automatically loaded
    into nix store, by the legacy secrets loader.
  */
  "wickedwizard.age" = {
    publicKeys = [ users.wickedwizard.secrets.encryption.key ];
    armor = true;
  };
  "maintenance.age" = {
    publicKeys = [ users.maintenance.secrets.encryption.key ];
    armor = true;
  };
  "selfhosted.age" = {
    publicKeys = [ users.selfhosted.secrets.encryption.key ];
    armor = true;
  };
  "lenovo-laptop.age" = {
    publicKeys = [ system.lenovo-laptop.secrets.encryption.key ];
    armor = true;
  };
  "hp-laptop.age" = {
    publicKeys = [ system.hp-laptop.secrets.encryption.key ];
    armor = true;
  };
  "oracle-server.age" = {
    publicKeys = [ system.oracle-server.secrets.encryption.key ];
    armor = true;
  };
}

/**
  wickedwizardPassword.age - Contains the password for user wickedwizard in hashed form.
  rootPassword.age - Contains the password for user root in hashed form.
  selfhostedPassword.age - Contains the password for user selfhosted in hashed form.
  hp-cachix-agent.nix - Contains CACHIX_AGENT_TOKEN= for acting as cachix agent.
  oracle-cachix-agent.nix - Contains CACHIX_AGENT_TOKEN= for acting as cachix agent.
  crowdsec-firewall-bouncer.age - Obtained by running `cscli bouncer add nixos-firewall`, and copy pasting the key directly. (Not an env var.)

  windows.age - Contains the Bitlocker recovery key.

  wickedwizard-backup.age - Contains the password for restic backup repository.

  important-files.age - Contains the password for Gocryptfs mount.
  rclone.age - Contains the rclone.conf file, as-is.
  cachix.age - Contains CACHIX_AUTH_TOKEN= (for cache) and CACHIX_DEPLOY_TOKEN= (for deployment)

  domains.age - Contains DOMAIN and its respective DUCKDNS_TOKEN
  email.age - Contains your email for Caddy, Let's Encrypt
  push-notifications.age - Contains Bitwarden Push Notification keys. (PUSH_INSTALLATION_ID, PUSH_INSTALLATION_KEY). More info - https://github.com/dani-garcia/vaultwarden/wiki/Enabling-Mobile-Client-push-notification
  proton-openvpn.age - Contains the OpenVPN username and password for ProtonVPN. (OPENVPN_USER, OPENVPN_PASSWORD)
  ente.age - Contains POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD, ENTE_DB_NAME, ENTE_DB_USER, ENTE_DB_PASSWORD. They match respectively. (i.e. POSTGRES_DB should have same value as ENTE_DB_NAME)
    Also contains MINIO_ROOT_USER, MINIO_ROOT_PASSWORD.
  wud.age - Contains env variables like WUD_TRIGGER_NTFY_UPDATENOTIF_TOPIC, WUD_AUTH_BASIC_JOHN_USER, WUD_AUTH_BASIC_JOHN_HASH, etc. Refer to https://getwud.github.io/wud/#/configuration/ for more info.
  n8n.age - Contains env variables like N8N_HOST, WEBHOOK_URL, N8N_RUNNERS_AUTH_TOKEN
  radicale.age - Contains the apache htpasswd file, for user authentication. Should be mounted as a file into the container, not environment variables.
  crowdsec-caddy-bouncer.age - See above; same as crowdsec-firewall-browser.age

  cloudflare-domains.age - Contains CLOUDFLARE_API_TOKEN, IP6_DOMAINS and PROXIED for cloudflare-ddns updater.

  freellmapi.age - Contains ENCRYPTION_KEY
  desec-domains.age - Contains DOMAIN, DESEC_TOKEN for that account.
*/
