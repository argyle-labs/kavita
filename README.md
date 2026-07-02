<p align="center">
  <img src="assets/icon-256.png" width="120" alt="kavita" />
</p>

# kavita

Kavita is a fast, self-hosted reading server for manga, comics, and ebooks.

A first-party [orca](https://github.com/argyle-labs/orca) plugin (service-backend).

This repo is **self-contained** — the steps below run kavita **by hand, without orca**. orca automates exactly this (same image, ports, and data) through one generic surface.

---

## Run it without orca

### Docker Compose

```yaml
# compose.yml
services:
  kavita:
    image: lscr.io/linuxserver/kavita:latest
    container_name: kavita
    restart: unless-stopped
    ports:
      - "5000:5000/tcp"   # web UI
    volumes:
      - ./config:/config
      - /path/to/library:/data
```

```sh
docker compose up -d
```

### Other runtimes

**Podman** — the compose above works with `podman compose up -d`, or run it directly:

```sh
podman run -d --name kavita --restart unless-stopped \
    -p 5000:5000/tcp \
    -v ./config:/config \
    -v /path/to/library:/data \
    lscr.io/linuxserver/kavita:latest
```

**LXC** — on a container-capable LXC (e.g. a Proxmox LXC with nesting enabled) run the same image via Docker/Podman as above, or install kavita from upstream directly on the guest: <https://www.kavitareader.com/>.

**VM** — install kavita from upstream (<https://www.kavitareader.com/>) or run the same container image inside the VM; expose port `5000`.

**Unraid** — add via *Community Applications*, or *Docker → Add Container* with image `lscr.io/linuxserver/kavita:latest`, port `5000`, and the volume paths above.

### Ports & data

| | |
|---|---|
| Default port | `5000` |
| Upstream | <https://www.kavitareader.com/> |
| Operator notes | [kavita.md](docs/kavita.md) |


### Backup & restore

Back up the config/data volume(s) above — that's the whole service state (stop the container first for a clean copy). Restore by putting them back and starting it.

> With orca this is **`service.backup` / `service.restore`** — location-agnostic (docker / podman / lxc / vm), one command regardless of where kavita runs. No per-service backup script.

## With orca

orca drives this plugin through the single generic `service.*` surface — no per-plugin tools:

```sh
orca service.deploy kavita      # render + launch on any supported runtime
orca service.status kavita      # health + rich diagnostics (typed payload)
orca service.backup kavita      # location-agnostic backup (tar; PBS on Proxmox)
orca service.configure kavita   # apply config via the upstream API
```

## Layout

- `src/` — the plugin (pure Rust): the `ServiceBackend` descriptor + `configure` / `status`.
- `docs/` — standalone operator notes.
- [CAPABILITIES.md](CAPABILITIES.md) — the service-backend contract checklist.
- `assets/` — plugin icon.
