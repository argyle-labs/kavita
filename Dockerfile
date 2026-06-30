# TODO: base image + build for kavita. Mirror jellyfin/Dockerfile conventions.
FROM debian:12-slim
LABEL org.opencontainers.image.source="https://github.com/argyle-labs/kavita"
EXPOSE 5000
