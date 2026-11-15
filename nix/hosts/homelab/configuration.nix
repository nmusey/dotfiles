{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../../common/options.nix
  ];

  config = {
    networking.hostName = "homelab";
    variables.global.username = "nick";
    variables.global.secretsFile = "/etc/homelab/homelab.env";

    presets.server = true;
    modules.base.boot.enable = false;
    modules.dev.godot.enable = false;
    modules.dev.unity.enable = false;
    modules.services = {
      adguard.enable = true;
      audiobookshelf.enable = true;
      bazarr.enable = true;
      caddy = {
        enable = true;
        address = "10.42.0.201";
        landingPage = ./static;
      };
      docker.enable = false;
      forgejo.enable = true;
      homeassistant.enable = true;
      immich.enable = true;
      jellyfin.enable = true;
      miniflux.enable = true;
      musicassistant.enable = true;
      navidrome.enable = true;
      paperless.enable = true;
      postgres.enable = true;
      prowlarr.enable = true;
      qbittorrent = {
        enable = true;
        wireguardConfigFile = "/etc/homelab/proton.conf";
      };
      radarr.enable = true;
      readeck.enable = true;
      restic.enable = true;
      searxng.enable = true;
      seerr.enable = true;
      sonarr.enable = true;
      sync.enable = true;
      tailscale.enable = true;
      valkey.enable = true;
    };

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };

    fileSystems."/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = [
        "nofail"
        "umask=0077"
      ];
    };

    fileSystems."/mnt/backup" = {
      device = "/dev/disk/by-label/backup";
      fsType = "ext4";
      options = [
        "nofail"
        "x-systemd.device-timeout=10s"
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      settings.publish = {
        disable-publishing = false;
        publish-addresses = true;
      };
    };

    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;
    hardware.raspberry-pi.firmware = {
      enable = true;
      uboot = {
        enable = true;
        package = pkgs.ubootRaspberryPi4_64bit;
      };
    };
    boot.supportedFilesystems.zfs = false;

    nixpkgs.overlays = [
      (
        final: prev:
        let
          noCheck = pkg: pkg.overrideAttrs { doInstallCheck = false; };
        in
        {
          pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
            (
              pyFinal: pyPrev:
              lib.genAttrs [
                "beat-this"
                "bokeh"
                "csvw"
                "duckdb"
                "duckdb-engine"
                "fastmcp"
                "frictionless"
                "ibis-framework"
                "librosa"
                "llama-index-core"
                "llama-index-embeddings-huggingface"
                "llama-index-embeddings-ollama"
                "llama-index-embeddings-openai"
                "llama-index-embeddings-openai-like"
                "llama-index-llms-ollama"
                "llama-index-llms-openai"
                "llama-index-llms-openai-like"
                "narwhals"
                "nnaudio"
                "ocrmypdf"
                "optuna"
                "phonemizer"
                "plotly"
                "scikit-learn"
                "segments"
                "sentence-transformers"
                "spacy"
                "spacy-loggers"
                "sqlframe"
                "sqlglot"
                "sweeps"
                "torchaudio"
                "torchlibrosa"
                "wandb"
                "xarray"
              ] (name: noCheck pyPrev.${name})
            )
          ];
          music-assistant = noCheck prev.music-assistant;
          paperless-ngx = noCheck prev.paperless-ngx;
        }
      )
    ];

    users.users.${config.variables.global.username}.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKmxw4WI7k418uf4nOfps7+CZK9nxG/bM245a4309mK nick@nixos"
    ];
    services.flatpak.enable = lib.mkForce false;
    security.sudo.wheelNeedsPassword = false;
    nix.settings.trusted-users = [
      "root"
      "@wheel"
    ];

    environment.sessionVariables = {
      # HOST_SPECIFIC = "value";
    };

    system.stateVersion = lib.mkForce "25.05";
  };
}
