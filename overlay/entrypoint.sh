#!/bin/sh

sed -i "s/ROOT_FOLDER_ID/$ROOT_FOLDER_ID/g" /root/.config/rclone/rclone.conf

exec "$@"
