#!/usr/bin/env bash

echo "Creating and Syncing Backup"
/etc/profiles/per-user/wickedwizard/bin/restic --verbose --password-file /home/wickedwizard/Documents/Config/Backup-Key.txt --repo rclone:backup:Backups backup /home/wickedwizard/Documents/
