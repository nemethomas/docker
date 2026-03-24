#!/bin/bash
cd /home/tom/docker

rclone copy /home/tom/docker/immich/upload/upload/ dropbox:backup/immich/upload/
rclone copy /home/tom/docker/immich/upload/thumbs/ dropbox:backup/immich/thumbs/
docker compose exec -T immich-db pg_dump -U immich immich > /home/tom/docker/immich/db_backup.sql
rclone copy /home/tom/docker/immich/db_backup.sql dropbox:backup/immich/db/
