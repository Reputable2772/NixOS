#!bash

sleep 30

cd $HOME/Documents/Applications/Containers

for folder in *; do
    echo "In $folder"
    cd $folder
    /etc/profiles/per-user/wickedwizard/bin/podman-compose up -d
    cd ..
done