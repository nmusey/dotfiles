# Disk layout for a from-scratch remote install via nixos-anywhere (see
# `make install-remote`), and the filesystems every later deploy mounts.
#
# Mirrors nixpkgs' own sd-image layout: a FAT32 firmware partition mounted at
# /boot/firmware (populated by hardware.raspberry-pi.firmware, enabled in
# configuration.nix) plus an ext4 root using the rest of the disk.
#
# `device` below is a guess (typical for an SD card) — verify against the
# real target with `lsblk` before installing. `make install-remote DISK=...`
# rewrites it here for you; or just edit
# it directly.
{
  disko.devices = {
    disk.main = {
      type = "disk";
      # OVERRIDE with `make install-remote DISK=...`, or edit here.
      # Wipes this device entirely — verify with `lsblk` on the target first.
      device = "/dev/mmcblk0";
      content = {
        type = "gpt";
        partitions = {
          firmware = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/firmware";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
