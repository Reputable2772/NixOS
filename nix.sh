#! /usr/bin/env bash

set +x

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
	nix flake check
}

case $1 in
	"build")
		build;;
	"changelog")
		changelog;;
	"check")
		check;;
	"dconf")
		dconf;;
	"fmt")
		format;;
	*)
    echo "Invalid option. Expected 'build', 'changelog', 'check', 'dconf' or 'fmt'";;
esac
