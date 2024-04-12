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

	for pc in $(nix flake show --json | jq '.nixosConfigurations | keys[]'); do
		nix --accept-flake-config derivation show -r .#nixosConfigurations."$pc".config.system.build.toplevel | jq > "derivations-$(echo $pc | tr -d '"').json"
	done

	touch hashes.txt
	touch builds.txt
	mkdir logs

	check_cache() {
		# outPath is $1
		if [ -d "$1" ]; then
			return 0
		fi

		hash=$(echo $1 | cut -d'/' -f4 | cut -d'-' -f1)
		if grep -Fxq "$hash" hashes.txt; then
			return 0
		fi

		caches=("https://cache.nixos.org" "https://nix-community.cachix.org" "https://numtide.cachix.org" "https://nixpkgs-wayland.cachix.org" "https://spearman4157.cachix.org")
		val=1

		for cache in "${caches[@]}"; do
			exists=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$cache/$hash.narinfo")
			if [ "$exists" == "200" ]; then
				val=0
				echo "$hash" >> hashes.txt
				break
			fi
		done

		return $val
	}

	test() {
		echo "Building $1" >> "logs/$(echo $1 | cut -d'/' -f4 | cut -d'-' -f1)"
		nix-build $1 >> "logs/$(echo $1 | cut -d'/' -f4 | cut -d'-' -f1)"
	}

	loop() {
		hash=$(echo $1 | cut -d'/' -f4 | cut -d'-' -f1)
		if ! check_cache $hash; then
			echo "No cache found for package: $1"

			for drv in $(cat $file | jq ".[] | select(.env.out == "$1") | .inputDrvs | keys[]"); do
				drv_hash=$(cat $file | jq ".["$drv"].env.out" | cut -d'/' -f4 | cut -d'-' -f1)
				if ! check_cache $drv_hash; then
					echo "Adding inputDrv: $drv - From Package: $1"
					echo "$drv" >> builds.txt
				fi
			done
		fi
	}

	export -f loop
	export -f check_cache
	export -f test

	for file in derivations-*.json; do
		export file
		(cat $file | jq '.[].env.out') | parallel loop
	done

	wait
	echo "Done"

	(cat builds.txt | tr -d '"') | parallel test
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
