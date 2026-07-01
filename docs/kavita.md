# Kavita

Books, comics, and manga reader.

- **Host**: <host> (<ip>)
- **Port**: 5000 (configurable via `KAVITA_PORT`)
- **Image**: `jvmilazz0/kavita`
- **Compose**: [compose/kavita/](../../compose/kavita/docker-compose.yml)

## Deploy

```bash
cd compose/kavita
docker compose up -d
```

## Environment Variables

| Variable             | Default          | Description                    |
| -------------------- | ---------------- | ------------------------------ |
| `TZ`                 | `Etc/UTC` | Timezone                       |
| `KAVITA_IMAGE_TAG`   | `latest`         | Image tag                      |
| `KAVITA_CONFIG_PATH` | `./config`       | Config directory               |
| `KAVITA_PORT`        | `5000`           | Host port                      |
| `MEDIA_PATH`         | *(required)*     | Base path — books/comics/manga subdirs are mounted |

## Initial Setup

Create admin account, add libraries for books/comics/manga.

## Troubleshooting

### Service Not Starting
```bash
docker compose logs kavita
```

### SQLite Database Lock

Stop the service, then remove lock files from the config volume:
```bash
find /path/to/config -name "*.db-shm" -o -name "*.db-wal" | xargs rm -f
```
