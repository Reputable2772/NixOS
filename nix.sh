#! /usr/bin/env bash

set -e

build() {
	echo "Builiding"
	rm -rf $HOME/.config/mimeapps.list
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
	echo "Building system CI"
	sudo rm -rf /usr/share/dotnet /opt/ghc "/usr/local/share/boost" "$AGENT_TOOLSDIRECTORY"
	nix-build .github/workflows/github-actions.nix
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
	"dconf")
		dconf_nix;;
	"format")
		format;;
	*)
    echo "Invalid option. Expected 'build', 'changelog', 'check', 'ci', 'dconf' or 'format'";;
esac
