#!/usr/bin/env bash

set -e

build() {
	echo "Copying non-declarative files"

	# If file is not a symlink, then copy it over if it is new.
	if [[ ! -L "$HOME/.config/mimeapps.list" ]]; then
		cp -pu "$HOME/.config/mimeapps.list" "$HOME/Documents/Config/mimeapps.list"
	fi

	echo "Builiding"
	sudo nixos-rebuild switch --flake .
}

changelog() {
	echo "Changelog"
	nix profile diff-closures --profile /nix/var/nix/profiles/system
}

check() {
	echo "Checking Flake config"
	nix flake check
}

ci() {
	# large docker images
    sudo docker image prune --all --force

	# large packages
	sudo apt-get purge -y '^llvm-.*' 'php.*' '^mongodb-.*' '^mysql-.*' azure-cli google-cloud-cli google-chrome-stable firefox powershell microsoft-edge-stable
    sudo apt-get autoremove -y
    sudo apt-get clean

	# large folders
    sudo rm -rf /var/lib/apt/lists/* /opt/hostedtoolcache /usr/local/games /usr/local/sqlpackage /usr/local/.ghcup /usr/local/share/powershell /usr/local/share/edge_driver /usr/local/share/gecko_driver /usr/local/share/chromium /usr/local/share/chromedriver-linux64 /usr/local/share/vcpkg /usr/local/lib/python* /usr/local/lib/node_modules /usr/local/julia* /opt/mssql-tools /etc/skel /usr/share/vim /usr/share/postgresql /usr/share/man /usr/share/apache-maven-* /usr/share/R /usr/share/alsa /usr/share/miniconda /usr/share/grub /usr/share/gradle-* /usr/share/locale /usr/share/texinfo /usr/share/kotlinc /usr/share/swift /usr/share/doc /usr/share/az_9.3.0 /usr/share/sbt /usr/share/ri /usr/share/icons /usr/share/java /usr/share/fonts /usr/lib/google-cloud-sdk /usr/lib/jvm /usr/lib/mono /usr/lib/R /usr/lib/postgresql /usr/lib/heroku /usr/lib/gcc /usr/share/dotnet /opt/ghc "/usr/local/share/boost" "$AGENT_TOOLSDIRECTORY"

	# TODO: Loop over all the derivations, check the ones that are in cache.
	# If not in cache, loop over its inputDrvs and build them.
	# Do this recursively till the bottom level of the chain.
	# Make sure to add the already cache checked paths to a file so that we don't end up spamming
	# cache/Cachix unnecessarily.

	check() {
		# Hash is $1
		if grep -Fxq "$1" hashes.txt; then
			return 0
		fi

		cache=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "https://cache.nixos.org/$1.narinfo")
		if [[ $cache != "200" ]]; then
			return 1
		fi

		return 0
	}

	rm -rf hashes.txt derivations-*.json build.txt

	for pc in $(nix flake show --json | jq '.nixosConfigurations | keys[]'); do
		nix derivation show -r .#nixosConfigurations."$pc".config.system.build.toplevel | jq > "derivations-$pc.json"
	done

	for file in derivations-*.json; do
		for outPath in $(cat $file | jq '.[].env.out'); do
			hash=$(echo $outPath | cut -d'/' -f4 | cut -d'-' -f1)
			if ! check $hash; then
				echo "No cache found for package: $outPath"

				for drv in $(cat $file | jq ".[] | select(.env.out == "$outPath") | .inputDrvs | keys[]"); do
					drv_hash=$(echo $drv | cut -d'/' -f4 | cut -d'-' -f1)
					if ! check $drv_hash; then
						echo "Adding inputDrv: $drv"
						echo "$drv" >> build.txt
					else
						echo "$drv_hash" >> hashes.txt
					fi
				done
			else
				echo "$hash" >> hashes.txt
			fi
		done
	done

	while read line; do
		echo "Building $line"
		nix-build $line
	done < build.txt
}

clean() {
	sudo nix-collect-garbage --delete-old
	nix-collect-garbage --delete-old
	# sudo nixos-rebuild boot --flake .#hp-laptop
}

dconf_nix() {
	echo "Dumping."
	dconf dump / | tee wickedwizard.dconf

	echo "Escaping special characters."
	sed -e 's/\\n//g' wickedwizard.dconf | tee wickedwizard.conf

	echo "Nixifying dconf"

	file="./Users/WickedWizard/Programs/Desktop/Gnome/dconf.nix"
	gnome_file="./Users/WickedWizard/Programs/Desktop/Gnome/gnome.nix"

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

depends() {
	echo "The nix derivation depends on $1 because: "
	NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix why-depends --impure --derivation .#nixosConfigurations.$(hostname).config.system.build.toplevel .#nixosConfigurations.$(hostname).pkgs.$1
}

format() {
	echo "Formatting files."
	nix fmt
}

first_time_setup() {
	if [ "$PWD" = "/etc/nixos" ]; then
		echo "Setup completed."
		exit
	fi

	echo "Symlinking current directory to /etc/nixos will completely remove all the config in /etc/nixos irrecoverably. This is needed for autoUpgrade functionality."
	echo "Hit enter to continue, or Ctrl + C to exit"

	read

	sudo rm -rf /etc/nixos
	sudo ln -s "$PWD" /etc/nixos

	echo "Setup completed."
}

last_unbroken() {
	# Taken from here # https://discourse.nixos.org/t/how-to-get-the-latest-unbroken-commit-for-a-broken-package-from-hydra/26354

	package=$1
	hydraURL=$(hydra-check --json "$package" | jq ".\"$package\" | .[0].build_url" -r)

	echo "Hydra URL: $hydraURL"

	evalID=$(curl -sH 'Accept: application/json' "$hydraURL" | jq '.jobsetevals | .[0]')
	eval=$(curl -sH 'Accept: application/json' https://hydra.nixos.org/eval/"$evalID")
	rev=$(echo "$eval" | jq '.jobsetevalinputs.nixpkgs.revision')
	evalDate=$(date --date @"$(echo "$eval" | jq '.timestamp')")

	echo "Last working Nixpkgs Revision: $rev, evaluated at $evalDate"
}

case $1 in
	"build")
		build;;
	"changelog")
		changelog;;
	"check")
		check;;
	"ci")
		ci;;
	"clean")
		clean;;
	"dconf")
		dconf_nix;;
	"format")
		format;;
	"first-time-setup")
		first_time_setup;;
	"why-depends")
		depends $2;;
	"last-unbroken")
		last_unbroken $2;;
	*)
		echo "Invalid option. Expected 'build', 'changelog', 'check', 'ci', 'dconf', 'format', 'first-time-setup', 'why-depends' or 'last-unbroken'";;
esac
