# Discord Evil Bot

## Description

The bot is used to manage the Evilist Discord Channel.

## Requirements

Create `.env` environment file.

```sh
APP_ID=
DISCORD_TOKEN=
GUILD_ID=
X_API_KEY=
```

## 🚀 Deployment

### TL;DR
1. **CI builds & pushes** a container image on every push to `main`.
2. The image is published to **GitHub Container Registry (GHCR)**.
3. The VPS **pulls and runs** that image in a single, root‑less container.

#### TODO:

- [ ] Webhook service on VPS that will automatically deploy a new bot when triggered.

---

### Why this workflow?

| Goal | Choice | Why it matters |
|------|--------|----------------|
| **Fast, reproducible builds** | **GitHub Actions** + `docker buildx` | Every commit is built in an identical runner, pinned to `package-lock.json`, so “works on my machine” is never a problem. |
| **Zero‑cost private registry** | **GHCR** | Free for open source, built‑in auth via `GITHUB_TOKEN`, <1 s push‑to‑pull latency. |
| **Small attack surface on the VPS** | **Single root‑less container** (`docker run -d --name bot …`) | No system packages, no Node.js on the host, no root privs inside the container. The bot only needs outbound HTTPS+WS. |
| **Instant roll‑backs** | Tagging: `:latest` **and** `:${GITHUB_SHA}` | If a deploy misbehaves, `docker run --rm ghcr.io/…:<sha>` + `docker stop bot && docker rename … bot` reverts in seconds. |
| **Crash/boot resilience** | `--restart unless-stopped` | Container auto‑starts after a host reboot and restarts on exit without external tooling. |
| **Secret management** | `--env-file .env` (never committed) | Keeps the Discord token out of Git; predictable injection into `process.env`. |

---

### Full command used on the server

```bash
docker run -d \
  --name bot \
  --env-file /home/bot/discord-evil-bot/.env \
  --restart unless-stopped \
  ghcr.io/m8mz/discord-evil-bot:latest
```

```sh
podman pull ghcr.io/m8mz/discord-evil-bot:latest
```

#### Rollback Strategy

```sh
docker run -d --name bot_prev ghcr.io/m8mz/discord-evil-bot:<sha>
docker stop bot
docker rename bot_prev bot
```
