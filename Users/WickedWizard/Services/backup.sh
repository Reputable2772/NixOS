#!/usr/bin/env bash

echo "Creating Backup"
/etc/profiles/per-user/wickedwizard/bin/restic -r /home/wickedwizard/Backups --password-file /home/wickedwizard/Documents/Config/Backup-Key.txt backup /home/wickedwizard/Documents/

echo "Syncing Backups"
/etc/profiles/per-user/wickedwizard/bin/rclone --verbose sync /home/wickedwizard/Backups backup:Backups
