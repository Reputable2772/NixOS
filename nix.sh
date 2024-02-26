#! /usr/bin/env bash

set -e

build() {
	echo "Builiding"
	sudo nixos-rebuild switch --flake .#hp-laptop
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
		nix-build -E "with import <nixpkgs> {}; callPackage $package {}"
	done

	mv ./Overlays/default.nix ./Overlays/default.nix.test

	for overlay in ./Overlays/*.nix; do
		nix-build -I "$NIX_PATH:nixpkgs-overlays=$PWD/Overlays" -E "with import <nixpkgs> {}; callPackage $(basename -s ".nix" $overlay) {}"
	done

	mv ./Overlays/default.nix.test ./Overlays/default.nix
}

clean() {
	sudo nix-collect-garbage --delete-old
	nix-collect-garbage --delete-old
	sudo nixos-rebuild boot --flake .#hp-laptop
}

dconf_nix() {
	echo "Dumping."
	dconf dump / | tee wickedwizard.dconf

	echo "Escaping special characters."
	sed -e 's/\\n//g' wickedwizard.dconf | tee wickedwizard.conf

	echo "Nixifying dconf"
	dconf2nix -i wickedwizard.conf -o ./Users/WickedWizard/Programs/Desktop/Gnome/gnome.nix

	echo "Deleting files"
	rm -rf *.conf *.dconf
}

format() {
	echo "Formatting files."
	nix fmt
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
	*)
    echo "Invalid option. Expected 'build', 'changelog', 'check', 'ci', 'dconf' or 'format'";;
esac
