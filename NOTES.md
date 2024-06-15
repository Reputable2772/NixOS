# First Time Setup Stuff.
* Bluetooth devices need to be paired, connected automatically. For a bluetooth device to automatically connect, you need to trust the device using `bluetoothctl trust <MAC>`

* Encrypted LUKS2 partitions keys need to be added to TPM2 to allow automatic unlocking.
Command: "systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 <Encrypted partition>"
0+7 is because Secure Boot is enabled. [Reference](https://wiki.archlinux.org/title/Systemd-cryptenroll#Trusted_Platform_Module)

# Implementation
The entire system is deployed by the CI (Github Actions) through Cachix Deploy. If the CI fails, no deployment is done. All the burden of building and pushing to Cachix rests on the CI. This can be found in `.github/workflows`.

The update CI runs everyday at 16:30. All systems are deployed if the CI passes.

* Currently there's no way to get rid of IFDs (IF that matters), especially those pesky `builtins.readFile` and `convertini` derivations, due to Catppuccin theming.
