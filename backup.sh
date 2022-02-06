#!/bin/sh
mkdir -p /opt/minecraft/backups
cd /opt/minecraft/backups
tar -C /opt/minecraft/paper -czf $(date +"%Y-%m-%d").tar.gz  world world_nether world_the_end
rm -f /opt/minecraft/backups/$(date --date='5 days ago' +"%Y-%m-%d").tar.gz
