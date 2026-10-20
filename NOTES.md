# Dev Notes & Weird Hacks

Notes for future me so I don't forget why I did weird things or break stuff during updates.

---

## First Time Setup
When setting up the system for the first time, there are some procedures to follow
- **Bluetooth**: Devices need to be paired, connected automatically. For a bluetooth device to automatically connect, you need to trust the device using `bluetoothctl trust <MAC>`
- **LUKS2 Partitions**: Encrypted LUKS2 partitions keys need to be added to TPM2 to allow PIN unlocking. [Reference](https://wiki.archlinux.org/title/Systemd-cryptenroll#Trusted_Platform_Module)
- **QT Theming**: Icons & Application themes must be manually setup in `qt5ct` & `qt6ct`. Kvantum & GTK are handled automatically.
- Calibre, KeePassXC theme also needs to be setup manually.

---

## CI & Updates
Cachix: `spearman4157`

CI is currently done by [build.yaml](.github/workflows/build.yml). It builds all the derivations of the flake, and pushes it to cachix.

Currently, updates are handled in [update.yaml](.github/workflows/update.yaml) & [PR.yaml](.github/workflows/pr.yaml)
- `update.yaml` is responsible for creating a PR every Saturday at 16:30 UTC.
- `pr.yaml` runs on the above opened PR, and checks to see if all builds pass. It also pushes the derivations to cachix.

Both build.yaml & update.yaml rely on [nix.sh](./nix.sh) for obtaining their trusted-substituters, trusted-public-keys and experimental-features.

`nix.sh` itself relies on a strict structure in [`System/Common/Misc/nix.nix`](System/Common/Misc/nix.nix).
1. All the properties required (trusted-substituters, etc.) must be defined in the above file only.
2. It must be a nix list, with only newlines in between elements. No comments are allowed between list elements.

---
## Selfhosted Services
All containers are run on Podman Rootless. However, inside the container, the services are run as root with UID & GID 0. This is to prevent permission conflicts outside the container.

Each host that has a selfhosted service, must also host a
`wireguard` & `docker-socket-proxy` container, along with a `caddy` network.

The entrypoint for the entire system is through the `astra-1` host.
The caddy on that system

WireGuard Network Addressing Convention:
  - Tunnel IP: 10.85.0.<id> (IPv6: fd85::<id>)
  - Local Podman Subnet: 10.<id * 10>.0.0/24 (IPv6: fdd6:61c:2978:<8000 + (id - 1) * 100>::/64)
  - Local Podman Gateway: 10.<id * 10>.0.1 (IPv6: ...::1)
Astra-1: Caddy - 10.10.0.0/24, fdd6:61c:2978:8000::/64, 10.85.0.1, fd85::1
Lenovo: Caddy - 10.20.0.0/24, fdd6:61c:2978:8100::/64, 10.85.0.2, fd85::2

For each wireguard container in the wireguard mesh, they must obey the following:
  - WIREGUARD_PRIVATE_KEY
  - WIREGUARD_PEER_<SERVER>_PUBLIC_KEY
  - Peers definition in [Config/config.nix](Config/config.nix) (For e.g., check out users.wickedwizard.containers.wireguard)
  - Fixed IP addresses, subnets, gateways, routes, DNS servers must be used in the quadlet (details given above)

The server may skimp on some of these rules, if necessary.

---

## 1. Impermanence & Root Rollback

**File**: `System/Lenovo-Laptop/Misc/impermanence.nix`

- Refer: https://www.notashelf.dev/posts/impermanence and https://guekka.github.io/nixos-server-1/ for the rollback script. I have no idea how that works.
- Real state must be saved in `/persist` or `/home`. Anything outside those directories will be wiped, permanently.
- Run `./Scripts/fs-diff.sh` to check what files accumulated on `/` that aren't persisted.

---

## 2. Secrets: `secretspec`

**Files**: `Modules/Common/secretspec.nix`, `Config/config.nix`

Custom secretspec module written for NixOS. Heavily inspired by agenix's workings. Key quirks:

- **Where secrets end up**:
  - System: `/run/secrets/`
  - User: `$XDG_RUNTIME_DIR/secrets/`
- **Host -> User Secret Sharing**:
  - NixOS decrypts host secrets into `/run/secrets/common` (chmod 0444).
  - Home Manager inherits them using the `file:///run/secrets/common` provider. No duplicate age keys or decrypt steps needed.
- **Runtime Secret Replacement (`@TOKEN@`)**:
  - Home-manager only.
  - For config files that need secrets but shouldn't have secrets leaked into the world-readable `/nix/store`.
  - Put `@TOKEN@` inside the config file.
  - In your module, add:
    ```nix
    secretspec.runtimeSecretReplacements."${config.xdg.configHome}/app/config.json" = {
      "@TOKEN@" = config.secretspec.secrets.profiles.<user>.<SECRET>.plainPath;
    };
    ```
  - During activation, a small Python script reads the Nix store symlink, swaps `@TOKEN@` with the decrypted secret, and writes the real file into place.

---

## 3. Quadlets Without IFD

**File**: `Modules/Home-Manager/quadlets.nix`

This modules pre-dates the one in HM, and was jankily written for only my use case.

- **How this works**: It structures quadlet lifecycle into three decoupled phases:
  1. **Preprocessing Phase (`preprocessors`)**: A customizable pipeline of ordered preprocessing modules (`programs.quadlets.preprocessors.<name>`).
  2. **Generation Phase**: All quadlets are packaged into a unified source tree (`pkgs.linkFarm`) and run through Podman's native `quadlet` generator in a single derivation.
	 - Sometimes, when modifying a single quadlet, all quadlets are restarted, due to how `sd-switch` (HM) works. This is because the SourcePath property of the quadlet changes. To prevent this from occuring, we strip it out by default.
     - After the quadlets are generated, all files need to be symlinked. However, this poses the question of how do we figure out the output file tree? This can be done using a `builtins.readDir` IFD, but that is really slow. Instead, we statically build a list from Unit.Wants, Unit.After, etc. To check if our statically built list is correct, we use a debug generator that checks if all the files in the file tree are in the statically generated list.
  3. **Linking Phase**: Statically links each predicted unit into `xdg.configFile."systemd/user/<unit>"`, avoiding IFD and directory collisions in Home Manager.

- **Pre-Processing** - Pre-Processing is done as mainly a convenience feature. It has `unitDefaults`, etc.

---

## 4. Pushing Config from Home-Manager to System

**Files**: `Modules/Common/config-module.nix`, `Modules/System/hm-config.nix`

Home Manager can't touch system options like firewall ports or unfree packages.

- Instead of hardcoding ports in host configs, declare them in the user module:
  ```nix
  system-config.firewall.allowedTCPPorts = [ 8080 ];
  system-config.nixpkgs.config.allowUnfreePredicate = [ "steam" ];
  ```
- `hm-config.nix` in the system layer collects all `system-config` blocks from all users, merges them, and applies them to the host firewall and nixpkgs config.
- It is badly written, and will result in infinite recursions if touched incorrectly.

---

## 5. nvfetcher module

**Files**: `Modules/Common/nvfetcher.nix`, `flake.nix`

- Don't write `nvfetcher.toml` manually.
- Add `programs.nvfetcher.config.<pkg>` directly in whatever module needs the source.
- `flake.nix` folds all those declarations across all hosts and shells into a single `nvfetcher.toml` (`nix build .#nvfetcher --out-link nvfetcher_ARCH.toml`).
- Run `nvfetcher` to update `_sources/`. (`nvfetcher --config nvfetcher_ARCH.toml --build-dir _sources/ARCH`)

---

## 6. Flatpak Theming Hacks

**Files**: `Users/WickedWizard/Programs/Desktop/Theming/themes.nix`, `Users/WickedWizard/Programs/Desktop/Theming/cursors.nix`

- Flatpaks can't access Home Manager symlinks in `~/.config/gtk-4.0`, `~/.config/gtk-3.0`, or `~/.local/share/icons`.
- `stylix.targets.gtk.flatpakSupport` is **disabled** because it doesn't handle these symlinks right. (Outdated info, should be tested again.)
- Instead, `flatpak-managed-install.service`:
  - `ExecStartPre`: runs `flatpak --user override --reset` so overrides don't accumulate forever.
  - `ExecStartPost`: runs `readlink` on `gtk.css`, `settings.ini`, and icon paths to find the real `/nix/store/...` paths, then calls `flatpak --user override --filesystem=...:ro`.

---

## 7. Spicetify + Flatpak Spotify

**File**: `Users/WickedWizard/Programs/Unfree/spotify.nix`

- Native Spotify on NixOS often breaks with Widevine. Flatpak is used instead.
- `programs.spicetify.enable = false` so spicetify-nix doesn't install native Spotify.
- `extraCommands` uses `sed` to patch `config-xpui.ini` so paths point inside `~/.local/share/flatpak/app/com.spotify.Client/...`.
- Desktop entry runs `spicetify && flatpak run com.spotify.Client`.

---

## 8. Rootless Caddy & Sockets

**File**: `Users/WickedWizard/Programs/Selfhosted/Containers/caddy.nix`

- Host sets `sysctl net.ipv4.ip_unprivileged_port_start = 80` (using the above system-config module).
- Systemd user socket (`caddy.socket`) opens 80, 443 TCP, and 443 UDP.
- Passed into Caddy container as file descriptors:
  - `fd/4` -> Port 80 (HTTP redirect)
  - `fd/5` -> Port 443 (HTTPS)
  - `fdgram/3` -> Port 443 UDP (HTTP/3)
- Caddy image is built on the host via Quadlet `.build` with `xcaddy` to compile in deSEC DNS (wildcard TLS) and CrowdSec bouncer plugins.
- To route a container, just add `containers.caddy.services.<subdomain> = "<container>:<port>"`.

---

## 9. Container Backups (`backup.nix`)

**File**: `Users/WickedWizard/Programs/Selfhosted/backup.nix`

- Runs daily at 21:00 via Restic.
- Before backing up:
  1. Stops all container services at once.
  2. Exports Podman volumes with `podman volume export <vol> --output <cache>/<vol>.tar.gz` (`PATH="/run/wrappers/bin:$PATH"` is set so `newuidmap` works).
  3. Takes Restic snapshot of volume tarballs + container data dirs.
  4. Restarts all container services.
- **Game saves**: `services.restic.preBackupScript` runs `ludusavi backup --force` before the main Restic backup runs.

---

## 10. Bug Workarounds

| Component | Reasons | File |
| :--- | :--- | :--- |
| **Lanzaboote** | Flake input pinned to `v1.2.0` so updates don't break secure boot. | `flake.nix` |
| **Memtest86+** | Unsigned EFI binaries fail under Secure Boot. `sign-memtest86.service` signs `memtest86plus.efi` with `sbctl` on boot. | `System/Lenovo-Laptop/Hardware/lanzaboote.nix` |
| **Bitwarden** | Desktop client silently blocks hibernation ([bitwarden#21661](https://github.com/bitwarden/clients/issues/21661)). Close it before hibernating. | `Users/WickedWizard/Programs/Selfhosted/bitwarden.nix` |
| **Hyprland UWSM** | `withUWSM = false;` because UWSM breaks portals and flatpak installs. | `System/Lenovo-Laptop/Packages/hyprland.nix` |
| **Hyprland setPath** | `hyprland.systemd.setPath.enable = false;` because nixpkgs puts `/run/wrappers/bin` after normal bin dirs. | `Modules/System/hyprland.nix` |
| **Waybar** | `programs.waybar.systemd.enable = false;` because systemd doesn't startup waybar correctly ([home-manager#3599](https://github.com/nix-community/home-manager/issues/3599)). | `Users/WickedWizard/Programs/Desktop/Hyprland/waybar.nix` |
| **GNOME GStreamer** | Sets `GST_PLUGIN_SYSTEM_PATH_1_0` in session vars or media apps fail to find codecs in HM ([nixpkgs#53631](https://github.com/NixOS/nixpkgs/issues/53631)). | `Users/WickedWizard/Programs/Desktop/Gnome/gnome.nix` |
| **Radicale** | Forces `UID=0` and `GID=0` in container or it drops perms and can't read mounted secrets. | `Users/WickedWizard/Programs/Selfhosted/Containers/radicale.nix` |
| **CrowdSec** | Sets `GroupAdd = "keep-groups"` in container or rootless podman can't read `/var/log/journal`. | `Users/WickedWizard/Programs/Selfhosted/Containers/crowdsec.nix` |
| **Rescue ISO** | Uses `lib.mkSinkUndeclaredOptions` and mkForce's `systemd.services.ip-update` to swallow options from `System/Common` without errors. | `System/Rescue/modules.nix` |
| **HP PAM gocryptfs** | Restores `PATH` with `/run/wrappers/bin` in wrapper script so PAM mount finds `fusermount`. | `System/HP-Laptop/gocryptfs.nix` |
| **MIME types** | Custom Python script parses `.desktop` files after flatpaks install because upstream `xdg.mimeApps` doesn't handle flatpaks. | `Modules/Home-Manager/mimeapps.nix` |
