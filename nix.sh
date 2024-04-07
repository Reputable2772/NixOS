#!/usr/bin/env bash

set -e

build() {
	echo "Copying non-declarative files"

	# If file is not a symlink, then copy it over if it is new.
	if [[ ! -L "$HOME/.config/mimeapps.list" ]]; then
		cp -pu "$HOME/.config/mimeapps.list" "$HOME/Documents/Config/mimeapps.list"
	fi

	echo "Builiding"
	sudo nixos-rebuild switch --flake .#$(hostname)
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
	sudo rm -rf /usr/share/dotnet /opt/ghc "/usr/local/share/boost" "$AGENT_TOOLSDIRECTORY"

	for package in ./Packages/*.nix; do
		NIXPKGS_ALLOW_UNFREE=1 nix-build -E "with import <nixpkgs> {}; callPackage $package {}"
	done

	mv ./Overlays/default.nix ./Overlays/default.nix.test

	echo "Nix Path: $NIX_PATH"

	for overlay in ./Overlays/*.nix; do
		NIXPKGS_ALLOW_UNFREE=1 nix-build -I "$NIX_PATH:nixpkgs-overlays=$PWD/Overlays" -E "with import <nixpkgs> {}; $(basename -s ".nix" $overlay)"
	done

	# Only temporary, a permanent solution is required.
	for package in $(grep -oP '"\K[^"\047]+(?=["\047])' ./System/HP-Laptop/Packages/unfree.nix); do
		NIXPKGS_ALLOW_UNFREE=1 nix-build -E "with import <nixpkgs> {}; $package"
	done

	mv ./Overlays/default.nix.test ./Overlays/default.nix
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
	NIXPKGS_ALLOW_INSECURE=1 nix why-depends --impure --derivation .#nixosConfigurations.$(hostname).config.system.build.toplevel .#nixosConfigurations.$(hostname).pkgs.$1
}

format() {
	echo "Formatting files."
	nix fmt
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
	"why-depends")
		depends $2;;
	"last-unbroken")
		last_unbroken $2;;
	*)
    echo "Invalid option. Expected 'build', 'changelog', 'check', 'ci', 'dconf', 'format', 'why-depends' or 'last-unbroken'";;
esac
