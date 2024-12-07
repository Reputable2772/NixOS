# First Time Setup Stuff.
* Bluetooth devices need to be paired, connected automatically. For a bluetooth device to automatically connect, you need to trust the device using `bluetoothctl trust <MAC>`

* Encrypted LUKS2 partitions keys need to be added to TPM2 to allow automatic unlocking.
Command: "systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 <Encrypted partition>"
0+7 is because Secure Boot is enabled. [Reference](https://wiki.archlinux.org/title/Systemd-cryptenroll#Trusted_Platform_Module)

* You need to manually setup Icon Themes and Application Theme for Qt5ct and Qt6ct. The Kvantum part is done by nix itself.

* Calibre, KeePassXC theme also needs to be setup manually.

* Follow everything after the [second point](https://github.com/catppuccin/joplin#usage) for Joplin.

* Applications whose config can never be declarative:
Spotify, Newsflash, Joplin, Vesktop, Wifi settings, Bitwarden, KDE Connect

# Implementation
The update CI runs on Saturday 16:30 (GMT +00:00). It opens a PR, and the PR is checked by the CI.

* Currently there's no way to get rid of IFDs (IF that matters), especially those pesky `builtins.readFile` and `convertini` derivations, due to Catppuccin theming.

* The selfhosted setup currently consists of a few services, namely Vaultwarden, Navidrome, Caddy, Syncthing.
* The Containers/utils.nix file handles the defaults, and a few useful functions such as Environment Files, variables, etc.
* Other files handle containers, lib funcs (which is responsible for secrets).

Syncthing, Vaultwarden, Linkding just requires app on Android
Navidrome requires two apps for android, namely DSub and Pano Scrobbler. Navidrome and Pano scrobble to musicbrainz, while DSub should _never_ scrobble to Navidrome. That should be handled by Pano only.
