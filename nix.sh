#!bash

set -e

echo "Formatting and checking files."
nix fmt
nix flake check

echo "Dumping DConf"
dconf dump / > wickedwizard.dconf
sudo -u shuba dconf dump / > shuba.conf

sed -e 's/\\n/\n/g' wickedwizard.dconf > wickedwizard.conf
sed -e 's/\\n/\n/g' shuba.dconf > shuba.conf

dconf2nix -i wickedwizard.conf -o ./WickedWizard/Programs/Desktop/Gnome/gnome.nix
dconf2nix -i shuba.conf -o ./Shuba/gnome.nix

echo "Actually builiding"
rm -rf /home/wickedwizard/Documents/Browsers/Firefox/search.json.mozlz4 /home/wickedwizard/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#nixos

echo "Changelog"
nix profile diff-closures --profile /nix/var/nix/profiles/system
