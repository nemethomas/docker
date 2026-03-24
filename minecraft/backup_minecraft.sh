#!/bin/bash
DATE=$(date +%Y-%m-%d)
REMOTE="dropbox:backup/minecraft"
TMP_ZIP=~/minecraft-worlds-backup.zip

# 1. Zip
zip -r $TMP_ZIP \
  ~/docker/minecraft/data/worlds \
  ~/docker/minecraft/data/server.properties \
  ~/docker/minecraft/data/permissions.json

# 2. Nach Dropbox (überschreibt immer die gleiche Datei)
rclone copy $TMP_ZIP $REMOTE/minecraft-worlds-latest.zip

# 3. Aufräumen
rm -f $TMP_ZIP

echo "Minecraft Backup fertig: $DATE"

