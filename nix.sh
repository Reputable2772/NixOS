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
	nix build .#nixosConfigurations.hp-laptop.config.system.build.toplevel --accept-flake-config --print-build-logs
}

dconf() {
	echo "DConf"
	dconf dump / > wickedwizard.dconf
	sudo -u shuba dconf dump / > shuba.dconf

	sed -e 's/\\n//g' wickedwizard.dconf > wickedwizard.conf
	sed -e 's/\\n//g' shuba.dconf > shuba.conf

	rm -rf ./wickedwizard.dconf
	rm -rf ./shuba.dconf

	dconf2nix -i wickedwizard.conf -o ./Users/WickedWizard/Programs/Desktop/Gnome/gnome.nix
	dconf2nix -i shuba.conf -o ./Users/Shuba/gnome.nix

	rm -rf ./wickedwizard.conf
	rm -rf ./shuba.conf
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
		dconf;;
	"format")
		format;;
	*)
    echo "Invalid option. Expected 'build', 'changelog', 'check', 'ci', 'dconf' or 'fmt'";;
esac
