{
  config,
  pkgs,
  inputs,
  ...
}:
{
  devshell =
    let
      _agenix = pkgs.applyPatches {
        name = "agenix-patched";
        src = inputs.agenix.outPath;
        patches = [ ./agenix.patch ];
      };
      agenix_args = inputs.agenix.inputs // {
        self = inputs.agenix.outputs;
      };
    in
    {
      name = "Development Shell for System Flake";
      packages = with pkgs; [
        coreutils
        curl
        jq
        hydra-check
        config.formatter
        nixpkgs-fmt
        nix-diff
        # A weird, but working hack. We import outputs of the patched flake, and then pass it the
        # args of the unpatched flake.

        # This hack is needed since agenix's src is a single file, and that cannot be patched.
        ((import "${_agenix}/flake.nix").outputs agenix_args).packages.${pkgs.system}.agenix
      ];

      startup.pre-commit.text = config.pre-commit.installationScript;
    };

  commands = [
    {
      help = "Run `nixos-rebuild --flake . --fast test` to test the current config.";
      name = "test-config";
      command = "nixos-rebuild --flake . --use-remote-sudo --fast test";
      category = "Development";
    }
    {
      help = "Garbage collect generations > 2 days old";
      name = "gc";
      command = ''
        sudo nix-collect-garbage --delete-older-than 2d
        nix-collect-garbage --delete-older-than 2d

        # Update bootloader entries
        sudo /run/current-system/bin/switch-to-configuration boot
      '';
    }
    {
      help = "Format files";
      name = "fmt";
      command = "nix fmt";
    }
    {
      help = "Build and switch to a new configuration";
      name = "switch";
      command = ''
        echo "Builiding"
        nixos-rebuild --flake . --use-remote-sudo switch
      '';
    }
    {
      help = "Check Flakes";
      name = "check";
      command = "nix flake check";
    }
    {
      help = "Show changelog with the previous revision.";
      name = "changelog";
      command = ''
        if [ -z $@ ]; then
          gen=$(nixos-rebuild list-generations --json | jq '.[] | select(.current == true) | .generation')
        else
          gen=$(echo $@)
        fi

        prev_gen=$(expr $gen - 1)
        nix-diff $(nix-store -qd "/nix/var/nix/profiles/system-$gen-link" "/nix/var/nix/profiles/system-$prev_gen-link")
      '';
    }
    {
      help = "Tell us exactly how our flake depends on a certain derivation";
      name = "why-depends";
      command = "NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix why-depends --impure --derivation .#nixosConfigurations.$(hostname).config.system.build.toplevel .#nixosConfigurations.$(hostname).$1";
    }
    {
      help = "Tell when a package last built successfully.";
      name = "last-successful-build";
      command = ''
        # Taken from here # https://discourse.nixos.org/t/how-to-get-the-latest-unbroken-commit-for-a-broken-package-from-hydra/26354

        package=$1
        hydraURL=$(hydra-check --json "$package" | jq ".\"$package\" | .[0].build_url" -r)

        echo "Hydra URL: $hydraURL"

        evalID=$(curl -sH 'Accept: application/json' "$hydraURL" | jq '.jobsetevals | .[0]')
        eval=$(curl -sH 'Accept: application/json' https://hydra.nixos.org/eval/"$evalID")
        rev=$(echo "$eval" | jq '.jobsetevalinputs.nixpkgs.revision')
        evalDate=$(date --date @"$(echo "$eval" | jq '.timestamp')")

        echo "Last working Nixpkgs Revision: $rev, evaluated at $evalDate"
      '';
    }
    {
      help = "Open a nix repl for current system";
      name = "repl";
      command = "nixos-rebuild --flake . repl";
    }
  ];
}
