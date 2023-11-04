#!bash

set -e

echo "Formatting and checking files."
nix fmt
nix flake check

if [ -n "$1" ] then
	echo "Dumping DConf"
	dconf dump / > wickedwizard.dconf
	sudo -u shuba dconf dump / > shuba.dconf

	sed -e 's/\\n//g' wickedwizard.dconf > wickedwizard.conf
	sed -e 's/\\n//g' shuba.dconf > shuba.conf

	rm -rf ./wickedwizard.dconf
	rm -rf ./shuba.dconf

	echo "DConf2Nix"
	dconf2nix -i wickedwizard.conf -o ./Users/WickedWizard/Programs/Desktop/Gnome/gnome.nix
	dconf2nix -i shuba.conf -o ./Users/Shuba/gnome.nix

	rm -rf ./wickedwizard.conf
	rm -rf ./shuba.conf
fi

echo "Actually builiding"
rm -rf $HOME/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#hp-laptop

echo "Changelog"
nix profile diff-closures --profile /nix/var/nix/profiles/system
