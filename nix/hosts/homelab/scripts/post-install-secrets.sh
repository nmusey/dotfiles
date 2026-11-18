#!/usr/bin/env bash
# Deploys the local .env (and proton.conf, if present) to the Pi and
# restarts every service that reads them.
#
# Run via `make secrets`, which passes the target and any SSH options
# (SSH_OPTS) from the Makefile's connection settings.
#
# Usage: scripts/post-install-secrets.sh <ssh-target> [path-to-env]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

TARGET="${1:-}"
ENV_FILE="${2:-$REPO_ROOT/.env}"
WG_FILE="$(dirname "$ENV_FILE")/proton.conf"

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <ssh-target> [path-to-env]" >&2
  exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "No .env found at $ENV_FILE — copy .env.example and fill in real values first." >&2
  exit 1
fi

SECRET_UNITS=(miniflux.service readeck.service searx-init.service searx.service)

echo ">> Copying $ENV_FILE to $TARGET:/etc/homelab/homelab.env"
ssh ${SSH_OPTS:-} "$TARGET" 'sudo mkdir -p /etc/homelab && sudo install -m 600 /dev/stdin /etc/homelab/homelab.env' < "$ENV_FILE"

if [ -f "$WG_FILE" ]; then
  echo ">> Copying $WG_FILE to $TARGET:/etc/homelab/proton.conf"
  ssh ${SSH_OPTS:-} "$TARGET" 'sudo install -m 600 /dev/stdin /etc/homelab/proton.conf' < "$WG_FILE"
  SECRET_UNITS+=(proton.service qbittorrent.service)
else
  echo ">> No proton.conf next to $ENV_FILE; qBittorrent stays down until one is uploaded"
fi

echo ">> Restarting services that read secrets"
ssh ${SSH_OPTS:-} "$TARGET" "sudo systemctl restart ${SECRET_UNITS[*]}"

echo "Done."
