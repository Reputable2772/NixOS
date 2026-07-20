#!/usr/bin/env bash

set -e

ci_get() {
	case $1 in
		"trusted-substituters")
			sed -n '/substituters = \[/, /];/{ /substituters = \[/! { /];/! p } }' ./System/Common/Misc/nix.nix | xargs;;
		"trusted-public-keys")
			sed -n '/trusted-public-keys = \[/, /];/{ /trusted-public-keys = \[/! { /];/! p } }' ./System/Common/Misc/nix.nix | xargs;;
		*)
			echo "Unknown, cya.";;
	esac
}

dconf_nix() {
	echo "Dumping."
	dconf dump / | tee wickedwizard.dconf

	echo "Escaping special characters."
	sed -e 's/\\n//g' wickedwizard.dconf | tee wickedwizard.conf

	echo "Nixifying dconf"

	file="./Users/WickedWizard/Programs/Desktop/Gnome/dconf.nix"
	gnome_file="./Users/WickedWizard/Programs/Desktop/Gnome/settings.nix"

	if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
		echo "Gnome Desktop Environment Found!"
		output_file=$gnome_file
	else
		echo "Found $XDG_CURRENT_DESKTOP"
		output_file=$file
	fi

	dconf2nix -i wickedwizard.conf -o $output_file

	echo "Deleting files"
	rm -rf *.conf *.dconf
}

first_time_setup() {
	echo "Modify Config/config.nix, and then hit enter."
	read

	# User isn't a trusted user yet to specify substituters and public keys
	sudo nix build .#nixosConfigurations."$(hostname)".config.system.build.toplevel \
		--accept-flake-config \
		--option pure-eval true \
		--option always-allow-substitutes true \
		--option trusted-substituters "$(ci_get trusted-substituters)" \
		--option extra-trusted-public-keys "$(ci_get trusted-public-keys)"

	sudo ./result/bin/switch-to-configuration switch

	echo "Do read ./NOTES.md, especially the First Time Setup section."
	echo "Setup completed."
}

find_blockers() {
	find . \
		-path '*/.*' -prune -o \
		-type f \
		-exec grep -nHE '[A-Za-z0-9._-]+/[A-Za-z0-9._-]+#[0-9]+' {} + | sed -E 's|([A-Za-z0-9._-]+/[A-Za-z0-9._-]+)#([0-9]+)|https://github.com/\1/issues/\2|g'
}

case $1 in
	"ci")
		ci;;
	# Meant for CI to get trusted-public-keys or trusted-substituters
	"ci_get")
		ci_get $2;;
	"dconf")
		dconf_nix;;
	"first-time-setup")
		first_time_setup;;
	*)
		echo "Invalid option. Expected 'ci', 'dconf' or 'first-time-setup'";;
esac
