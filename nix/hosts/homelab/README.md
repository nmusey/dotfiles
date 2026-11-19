# homelab

Raspberry Pi 4 server. Services are enabled in `configuration.nix`; their
modules live in `../../common/services/`. Run everything from this directory
through `make` (`make help` lists the targets).

## Setup

- **Building on x86_64** needs `boot.binfmt.emulatedSystems = [ "aarch64-linux" ];`
  (tower already has it). Otherwise use `make deploy-native` to build on the Pi.
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

- `make ssh`, then `sudo tailscale up`.
- Trust Caddy's local CA on your devices, or HTTPS will warn on every
  `*.home.lan` site: `sudo find /var/lib/caddy -name root.crt`.
- Give the backup drive the ext4 label `backup` so it mounts at `/mnt/backup`.
- Finish each service's setup in its web UI. Links are on `https://home.lan/admin/`.

## Updating

| Change | Command |
|---|---|
| Any `.nix` file | `make deploy` (or `make deploy-native`) |
| Try a change without making it the boot default | `make test` |
| `.env` or `proton.conf` | `make secrets` |
| Undo the last deploy | `make rollback` |
| Check that it builds, no deploy | `make build` |
| Pull newer packages | `nix flake update`, then `make deploy` |
