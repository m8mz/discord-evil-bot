#!/bin/bash

docker run -d \
  --name bot \
  --env-file .env \
  --restart unless-stopped \
  ghcr.io/m8mz/discord-evil-bot:latest
