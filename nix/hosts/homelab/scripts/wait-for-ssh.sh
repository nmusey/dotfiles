#!/usr/bin/env bash
# Waits for a freshly-installed Pi to come up over SSH. Helper for
# `make install-remote` — run that, not this
# directly.
#
# A reinstall always generates new SSH host keys, so the old known_hosts
# entry for this host would make ssh refuse to connect ("REMOTE HOST
# IDENTIFICATION HAS CHANGED"). This removes that entry and accepts the new
# key on first connect. Only ever called right after wiping the Pi, when a
# changed key is expected.
#
# Uses SSH_OPTS from the environment, same as post-install-secrets.sh.
#
# Usage: scripts/wait-for-ssh.sh <ssh-target> [timeout-seconds]

set -euo pipefail

TARGET="${1:-}"
TIMEOUT="${2:-600}"

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <ssh-target> [timeout-seconds]" >&2
  exit 1
fi

# shellcheck disable=SC2086 # SSH_OPTS is deliberately word-split
HOST="$(ssh ${SSH_OPTS:-} -G "$TARGET" | awk '$1 == "hostname" { print $2 }')"
PORT="$(ssh ${SSH_OPTS:-} -G "$TARGET" | awk '$1 == "port" { print $2 }')"

echo ">> Removing the old host key for $HOST from known_hosts (it changes on reinstall)"
ssh-keygen -R "$HOST" >/dev/null 2>&1 || true
[ "$PORT" = "22" ] || ssh-keygen -R "[$HOST]:$PORT" >/dev/null 2>&1 || true

echo ">> Waiting up to ${TIMEOUT}s for $TARGET to come up over SSH..."
deadline=$(( $(date +%s) + TIMEOUT ))
# shellcheck disable=SC2086
until ssh ${SSH_OPTS:-} -o BatchMode=yes -o ConnectTimeout=5 \
    -o StrictHostKeyChecking=accept-new "$TARGET" true >/dev/null 2>&1; do
  if [ "$(date +%s)" -ge "$deadline" ]; then
    echo "Couldn't reach $TARGET after ${TIMEOUT}s. Once it's up, run: make post-install" >&2
    exit 1
  fi
  sleep 5
done
echo ">> $TARGET is up."
