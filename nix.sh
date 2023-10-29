#!bash

set -e

echo "Formatting and checking files."
nix fmt
nix flake check

echo "Dumping DConf"
dconf dump / > wickedwizard.dconf
sudo -u shuba dconf dump / > shuba.dconf

sed -e 's/\\n//g' wickedwizard.dconf > wickedwizard.conf
sed -e 's/\\n//g' shuba.dconf > shuba.conf

echo "DConf2Nix"

dconf2nix -i wickedwizard.conf -o ./Users/WickedWizard/Programs/Desktop/Gnome/gnome.nix
dconf2nix -i shuba.conf -o ./Users/Shuba/gnome.nix

rm -rf ./wickedwizard.dconf ./wickedwizard.conf
rm -rf ./shuba.dconf ./shuba.conf

echo "Actually builiding"
rm -rf $HOME/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#hp-laptop

echo "Changelog"
nix profile diff-closures --profile /nix/var/nix/profiles/system
