#!/usr/bin/env bash
# Remotely install NixOS onto the Pi over SSH via nixos-anywhere + disko —
# no physical access to the device required. Helper for
# `make install-remote`, which also waits for the reboot and deploys
# secrets afterwards — run that, not this directly. See the Makefile header for
# prerequisites (passwordless sudo or root SSH on the current Ubuntu
# install, wired ethernet recommended).
#
# This WIPES the target disk. Ubuntu Server (and everything on it) is gone
# after this runs.
#
# Uses SSH_OPTS from the environment (e.g. "-p 22 -i ~/.ssh/key"), same as
# the other helpers; empty when the target comes from ~/.ssh/config.
#
# Usage: scripts/install-remote.sh <ssh-target> [disk-device]

set -euo pipefail

HOST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DISKO_FILE="$HOST_DIR/disko.nix"

TARGET="${1:-}"
DISK_OVERRIDE="${2:-}"

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <ssh-target> [disk-device]" >&2
  exit 1
fi

# nixos-anywhere doesn't take raw ssh flags, so translate the -p/-i that
# the Makefile's .env fallback produces into its own equivalents.
read -r -a ssh_opts <<< "${SSH_OPTS:-}"
anywhere_opts=()
for ((i = 0; i < ${#ssh_opts[@]}; i++)); do
  case "${ssh_opts[i]}" in
    -p) anywhere_opts+=(--ssh-port "${ssh_opts[i + 1]}"); i=$((i + 1)) ;;
    -i) anywhere_opts+=(-i "${ssh_opts[i + 1]}"); i=$((i + 1)) ;;
  esac
done

CURRENT_DISK="$(grep -oP '(?<=device = ")[^"]+' "$DISKO_FILE")"

if [ -n "$DISK_OVERRIDE" ] && [ "$DISK_OVERRIDE" != "$CURRENT_DISK" ]; then
  echo ">> Updating $DISKO_FILE to use $DISK_OVERRIDE"
  sed -i "s|device = \"$CURRENT_DISK\";|device = \"$DISK_OVERRIDE\";|" "$DISKO_FILE"
  DISK="$DISK_OVERRIDE"
else
  DISK="$CURRENT_DISK"
fi

echo "=================================================================="
echo " This will COMPLETELY WIPE $DISK on $TARGET and install NixOS."
echo " Ubuntu Server and everything on it will be gone. Not reversible."
echo "=================================================================="
echo
echo ">> Current block devices on $TARGET:"
# shellcheck disable=SC2086 # SSH_OPTS is deliberately word-split
ssh ${SSH_OPTS:-} "$TARGET" 'lsblk -o NAME,SIZE,MODEL,MOUNTPOINT' || {
  echo "Couldn't SSH to $TARGET — check the host and that your key is authorized." >&2
  exit 1
}
echo
read -r -p "Type the disk device to confirm ($DISK): " CONFIRM
if [ "$CONFIRM" != "$DISK" ]; then
  echo "Confirmation didn't match, aborting." >&2
  exit 1
fi

echo ">> Running nixos-anywhere against $TARGET"
nix run github:nix-community/nixos-anywhere -- \
  --flake "$HOST_DIR#homelab" \
  --target-host "$TARGET" \
  "${anywhere_opts[@]}"

echo ">> Install finished. The Pi should be rebooting into NixOS now."
