#!/usr/bin/env bash

set -e

ci() {
	ci_increase_storage

	LIX_CONF_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/nix/nix.conf"
	echo "experimental-features = flakes nix-command pipe-operators" >> "$LIX_CONF_FILE"

	nix --version
	nix config show

	cat "$LIX_CONF_FILE"

	# Inherited from devenv's ci shell.
	check

	# Set here and not in Lix Install Actions because
	# https://github.com/canidae-solutions/lix-quick-install-action/blob/51fe8b3eafcb89b46341a8088ab0d3a849efbf5b/nix-quick-install.sh#L107
	nix-fast-build --debug --no-nom --out-link lenovo-laptop --flake .#nixosConfigurations.lenovo-laptop.config.system.build.toplevel

	# The variable `attr` is not checked for nullish values
	# https://github.com/Mic92/nix-fast-build/blob/f024a66e6a1f83de95aba109287a97dd6ca76127/nix_fast_build/__init__.py#L605
	mv lenovo-laptop- lenovo-laptop

	echo $(realpath lenovo-laptop) | cachix push spearman4157
}

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

ci_increase_storage() {
	# large docker images
    sudo docker image prune --all --force

	# large packages
	sudo apt-get purge -y '^llvm-.*' 'php.*' '^mongodb-.*' '^mysql-.*' azure-cli google-cloud-cli google-chrome-stable firefox powershell microsoft-edge-stable
    sudo apt-get autoremove -y
    sudo apt-get clean

	# large folders
    sudo rm -rf /var/lib/apt/lists/* /opt/hostedtoolcache /usr/local/games /usr/local/sqlpackage /usr/local/.ghcup /usr/local/share/powershell /usr/local/share/edge_driver /usr/local/share/gecko_driver /usr/local/share/chromium /usr/local/share/chromedriver-linux64 /usr/local/share/vcpkg /usr/local/lib/python* /usr/local/lib/node_modules /usr/local/julia* /opt/mssql-tools /etc/skel /usr/share/vim /usr/share/postgresql /usr/share/man /usr/share/apache-maven-* /usr/share/R /usr/share/alsa /usr/share/miniconda /usr/share/grub /usr/share/gradle-* /usr/share/locale /usr/share/texinfo /usr/share/kotlinc /usr/share/swift /usr/share/doc /usr/share/az_9.3.0 /usr/share/sbt /usr/share/ri /usr/share/icons /usr/share/java /usr/share/fonts /usr/lib/google-cloud-sdk /usr/lib/jvm /usr/lib/mono /usr/lib/R /usr/lib/postgresql /usr/lib/heroku /usr/lib/gcc /usr/share/dotnet /opt/ghc "/usr/local/share/boost" "$AGENT_TOOLSDIRECTORY"
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

case $1 in
	"ci")
		ci;;
	# Meant for CI to get trusted-public-keys or trusted-substituters
	"ci_get")
		ci_get $2;;
	"ci_increase_storage")
		ci_increase_storage;;
	"dconf")
		dconf_nix;;
	"first-time-setup")
		first_time_setup;;
	*)
		echo "Invalid option. Expected 'ci', 'dconf' or 'first-time-setup'";;
esac
