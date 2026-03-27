#!/bin/bash
rclone copy /home/tom/docker/immich/upload/upload/ dropbox:backup/immich/upload/ \
  --dropbox-batch-mode async \
  --dropbox-batch-size 100 \
  --transfers 2 \
  --tpslimit 8 \
  --retries 10 \
  --retries-sleep 30s

rclone copy /home/tom/docker/immich/upload/thumbs/ dropbox:backup/immich/thumbs/ \
  --dropbox-batch-mode async \
  --dropbox-batch-size 100 \
  --transfers 2 \
  --tpslimit 8 \
  --retries 10 \
  --retries-sleep 30s

docker compose -f /home/tom/docker/docker-compose.yml exec -T immich-db pg_dump -U immich immich > /home/tom/docker/immich/db_backup.sql

rclone copy /home/tom/docker/immich/db_backup.sql dropbox:backup/immich/db/
