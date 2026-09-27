# Nix hosts

Each directory represents a host for a nix machine.
Each host has a few customization options, but most of the configuration should be
done in common modules so it can be reused across machines.

## Adding a host

```sh
HOSTNAME=new-nix-host
mkdir $HOSTNAME
cp configuration-template.nix $HOSTNAME/configuration.nix
cp tower/flake.nix $HOSTNAME/flake.nix
cd $HOSTNAME

sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix

# Edit flake.nix (description + nixosConfigurations.<hostname>)
# Edit configuration.nix (hostname, packages, modules)

sudo nixos-rebuild switch --flake .#$HOSTNAME
```

### Host template
In `configuration.nix`, replace the hostname, add host-specific packages under
`environment.systemPackages`, and enable modules.
Modules are listed in [options/](../common/options), split into `core`, `dev`,
`programs` and `services`; each file declares its modules' options and defaults.
