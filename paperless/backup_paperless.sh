#!/bin/bash
DATE=$(date +%Y-%m-%d)
REMOTE="dropbox:backup/dms"
TMP_DUMP=~/docker/paperless/db_dump_tmp.sql

RCLONE_OPTS="
  --dropbox-batch-mode async \
  --dropbox-batch-size 100 \
  --transfers 2 \
  --tpslimit 8 \
  --retries 10 \
  --retries-sleep 30s"

# 1. DB Dump
docker exec docker-paperless-db-1 pg_dump -U paperless paperless > $TMP_DUMP

# 2. Alles nach Dropbox
rclone copy ~/docker/paperless/media/ $REMOTE/media/ --exclude ".DS_Store" $RCLONE_OPTS
rclone copy ~/docker/paperless/data/ $REMOTE/data/ $RCLONE_OPTS
rclone copy $TMP_DUMP $REMOTE/db_latest.sql

# 3. Tmp Dump wieder löschen
rm -f $TMP_DUMP

echo "Backup fertig: $DATE"
