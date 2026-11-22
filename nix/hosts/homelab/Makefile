# Build and deploy the homelab from any NixOS machine.
#
# The Pi must already run NixOS from the standard aarch64 SD image (FIRMWARE +
# NIXOS_SD partitions); `make deploy` switches it to this flake in place.
# There's no remote reinstall: nixos-anywhere needs kexec, and the Pi 4's
# spin-table firmware can't offline CPUs for it.
#
# Connecting: if ~/.ssh/config has a `Host homelab` entry (or whatever
# SSH_HOST is set to), that's used as-is and nothing from .env is needed.
# Otherwise the target is built from .env's DEPLOY_USER/HOST_IP/DEPLOY_PORT/
# SSH_KEY. Anything can be overridden per run, e.g.
# `make deploy SSH_HOST=otherpi` or `make deploy HOST_IP=homelab.local`.
#
# `deploy` and `boot` build on the Pi itself. `deploy-local` and `boot-local`
# build on this machine instead, which on x86_64 needs
# `boot.binfmt.emulatedSystems = [ "aarch64-linux" ];`.

SHELL    := bash
ENV_FILE ?= .env
FLAKE    := .\#homelab
SYSTEM   := .\#nixosConfigurations.homelab.config.system.build

# Reads just the one key out of .env rather than `include`-ing it, so
# secrets containing make syntax ($, #, :=) can't break parsing.
env_get = $(shell [ -f $(ENV_FILE) ] && sed -n 's/^$(1)=//p' $(ENV_FILE) | tail -n1)

SSH_HOST := $(or $(SSH_HOST),$(call env_get,SSH_HOST),homelab)

# `ssh -G` prints the config ssh would actually use for a host. If the
# resolved hostname differs from SSH_HOST, a Host entry with a HostName
# matched it — so let ssh's own config handle user/port/key.
SSH_CONFIGURED := $(shell [ "$$(ssh -G $(SSH_HOST) 2>/dev/null | awk '$$1 == "hostname" { print $$2 }')" != "$(SSH_HOST)" ] && echo yes)

ifeq ($(SSH_CONFIGURED),yes)
TARGET   := $(SSH_HOST)
SSH_OPTS :=
else
DEPLOY_USER := $(or $(DEPLOY_USER),$(call env_get,DEPLOY_USER),nick)
HOST_IP     := $(or $(HOST_IP),$(call env_get,HOST_IP),homelab.local)
DEPLOY_PORT := $(or $(DEPLOY_PORT),$(call env_get,DEPLOY_PORT),22)
SSH_KEY     := $(or $(SSH_KEY),$(call env_get,SSH_KEY),$(HOME)/.ssh/id_ed25519)
SSH_KEY     := $(patsubst ~/%,$(HOME)/%,$(SSH_KEY))
TARGET      := $(DEPLOY_USER)@$(HOST_IP)
SSH_OPTS    := -p $(DEPLOY_PORT) -i $(SSH_KEY)
endif

SSH     := ssh $(SSH_OPTS) $(TARGET)
# --use-remote-sudo rather than --sudo: the older (bash) nixos-rebuild only
# knows the former, and the newer one still accepts it as a deprecated alias.
REBUILD := NIX_SSHOPTS="$(SSH_OPTS)" \
           nixos-rebuild --flake $(FLAKE) --target-host $(TARGET) --use-remote-sudo
# Passed to every scripts/ helper so they connect the same way.
HELPER_ENV := SSH_OPTS="$(SSH_OPTS)"

.DEFAULT_GOAL := help
.PHONY: help stage build deploy deploy-local test boot boot-local rollback secrets ssh

help: ## List targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-15s %s\n", $$1, $$2}'
	@echo
	@echo "  target: $(TARGET)$(if $(SSH_CONFIGURED), (from ~/.ssh/config), (from .env: $(SSH_OPTS)))"

# Flakes ignore untracked files entirely, so a brand-new module would
# silently be left out of the build. --intent-to-add makes new files
# visible without actually staging their contents.
stage:
	@git add --intent-to-add "$$(git rev-parse --show-toplevel)/nix"

build: stage ## Build the system closure locally (no deploy)
	nix build $(SYSTEM).toplevel

deploy: stage ## Build on the Pi and switch to it
	$(REBUILD) --build-host $(TARGET) switch

deploy-local: stage ## Build locally, copy to the Pi, and switch to it
	$(REBUILD) switch

test: stage ## Build locally, copy and activate without making it the boot default
	$(REBUILD) test

boot: stage ## Build on the Pi and make it the default for the next reboot
	$(REBUILD) --build-host $(TARGET) boot

boot-local: stage ## Build locally, copy to the Pi, and make it the default for the next reboot
	$(REBUILD) boot

rollback: ## Switch the server back to its previous generation
	$(REBUILD) switch --rollback

secrets: ## Upload .env (and proton.conf) to the server and restart everything that reads them
	@$(HELPER_ENV) scripts/post-install-secrets.sh $(TARGET) $(ENV_FILE)

ssh: ## Open a shell on the server
	$(SSH)
