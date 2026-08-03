# Kavita

Books, comics, and manga reader.

- **Image**: `ghcr.io/kareadita/kavita:latest`
- **Port**: `5000` (web UI)
- **Config**: `/kavita/config` inside the container — holds the SQLite database, settings, and cover cache
- **Library data**: mount your books/comics/manga into the container and point Kavita's libraries at them from the web UI

## Deploy

See the [README](../README.md) for the compose file and per-runtime (Docker, Podman, LXC, VM, Unraid) instructions. In short:

```sh
docker compose up -d
```

Then open `http://<server>:5000` and create the admin account.

## Volumes

| Container path      | Purpose                                          |
| ------------------- | ------------------------------------------------ |
| `/kavita/config`    | Database, settings, cover cache — the service state |
| *(library mounts)*  | Your books/comics/manga; add libraries in the UI |

## Initial Setup

1. Browse to the web UI on port `5000`.
2. Create the admin account.
3. Add libraries for books, comics, and manga, pointing each at the mounted library paths.

## Troubleshooting

### Service not starting

```sh
docker compose logs kavita
```

### SQLite database lock

Stop the service, then remove the WAL/SHM lock files from the config volume:

```sh
find /path/to/config -name "*.db-shm" -o -name "*.db-wal" | xargs rm -f
```

## Backup & restore

The config volume is the entire service state. Stop the container for a clean copy, back up the config directory, then restore by putting it back and restarting.

Under orca this is `service.backup` / `service.restore` — location-agnostic across docker / podman / lxc / vm.
</content>
</invoke>
