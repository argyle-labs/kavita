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

## Scan-on-import integration (orca)

New ebooks/comics land on the willow share (watcher won't fire), so scans are
pushed by the [download-client scan dispatcher](../../sabnzbd/docs/scan-dispatcher.md)
on `books`/`comics`/`manga` category completions.

**API:** `POST /api/Account/login` `{username,password}` → `token` (JWT), then
`POST /api/Library/scan?libraryId={id}` with `Authorization: Bearer <jwt>`.
`GET /api/Library/libraries` lists ids. Libraries: **Books** `2`, **Comics** `1`.
Kavita also issues a per-user **API key** (Dashboard → account) that can be
exchanged for a JWT via `POST /api/Plugin/authenticate?apiKey=…&pluginName=orca`.

**Creds:** 1Password `kavita (orca)` (orca vault). **Endpoint:**
`http://10.0.0.6:5000` (baldur).

**Future plugin capability:** expose `scan` + `configure` (register import hook).
See [CAPABILITIES.md](../CAPABILITIES.md).
