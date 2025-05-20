FROM alpine:3.21

COPY ./overlay/ /

RUN apk add --no-cache rclone mariadb-client bash && chmod +x /entrypoint.sh && chmod +x /sync.sh

WORKDIR /backup

ENTRYPOINT ["/entrypoint.sh"]
