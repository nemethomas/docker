#!/bin/bash
DATE=$(date +%Y-%m-%d)
REMOTE="dropbox:backup/dms"
TMP_DUMP=~/docker/paperless/db_dump_tmp.sql

# 1. DB Dump
docker exec docker-paperless-db-1 pg_dump -U paperless paperless > $TMP_DUMP

# 2. Alles nach Dropbox
rclone copy ~/docker/paperless/media/ $REMOTE/media/ --exclude ".DS_Store" 
rclone copy ~/docker/paperless/data/ $REMOTE/data/
rclone copy $TMP_DUMP $REMOTE/db_latest.sql

# 3. Tmp Dump wieder löschen
rm -f $TMP_DUMP

echo "Backup fertig: $DATE"
