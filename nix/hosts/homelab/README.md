# homelab

Raspberry Pi 4 server. Services are enabled in `configuration.nix`; their
modules live in `../../common/services/`. Run everything from this directory
through `make` (`make help` lists the targets).

## Setup

- **Where it builds:** `make deploy` and `make boot` build on the Pi.
  `make deploy-local` and `make boot-local` build on this machine instead, which
  on x86_64 needs `boot.binfmt.emulatedSystems = [ "aarch64-linux" ];` (tower
  already has it).
- **Connection:** add a `Host homelab` entry to `~/.ssh/config`, or fill in
  `HOST_IP` / `DEPLOY_USER` / `DEPLOY_PORT` / `SSH_KEY` in `.env`.
- **Secrets** (both git-ignored):
  - `cp .env.example .env` and fill it in.
  - Save a Proton VPN WireGuard config as `proton.conf` in this directory.
    qBittorrent stays down without it.

## First install

Flash the NixOS aarch64 SD image (it has the `FIRMWARE` and `NIXOS_SD`
partitions that `configuration.nix` mounts), boot it, and make sure you can
SSH in with sudo. Then switch it to this flake in place:

```sh
make deploy
make secrets
```

Remote reinstalls (nixos-anywhere) don't work on the Pi 4. They need kexec, and
the Pi's spin-table firmware can't take CPUs offline for it.

Then, once:

- `make ssh`, then `sudo tailscale up`. In the Tailscale admin console:
  - Approve the homelab's `192.168.0.101/32` subnet route.
  - Under DNS, add `192.168.0.101` as a split DNS nameserver for `musey.casa`.

  After that, `*.musey.casa` resolves and loads from any tailnet device, even
  away from home. Linux clients also need `sudo tailscale set --accept-routes`.
- HTTPS uses a Let's Encrypt wildcard for `*.musey.casa`, issued over DNS-01
  through the Namecheap API. Fill in `NAMECHEAP_API_*` in `.env` and whitelist
  the home's public IPv4 in Namecheap before deploying. If the public IP
  changes, renewals fail until the whitelist is updated. Check with
  `journalctl -u acme-order-renew-musey.casa`.
- Give the backup drive the ext4 label `backup` so it mounts at `/mnt/backup`.
- Finish each service's setup in its web UI. Links are on `https://musey.casa/admin/`.

## Updating

| Change | Command |
|---|---|
| Any `.nix` file | `make deploy` (or `make deploy-local`) |
| Apply on next reboot instead of now | `make boot` (or `make boot-local`) |
| Try a change without making it the boot default | `make test` |
| `.env` or `proton.conf` | `make secrets` |
| Undo the last deploy | `make rollback` |
| Check that it builds, no deploy | `make build` |
| Pull newer packages | `nix flake update`, then `make deploy` |
