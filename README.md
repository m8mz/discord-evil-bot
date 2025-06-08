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

## Deployment

Github Repo Registry

```sh
podman pull ghcr.io/m8mz/discord-evil-bot:latest
./start.sh
```

```sh
docker run -d \
  --name bot \
  --env-file .env \
  --restart unless-stopped \
  ghcr.io/m8mz/discord-evil-bot:latest
```
