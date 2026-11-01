# kei-nixos

This is my personal NixOS config: the specific setup I use on one machine. To
reuse it, replace all instances of `kei-nixos` with the desired hostname and
`kei` with the desired user name. For the actual dotfiles, see
[my dotfiles repo](https://github.com/Nirvaxstiel/dotfiles).

I keep personal config files out of this repo; they live in chezmoi instead. A
Nix-built config is a read-only symlink into the store, so saving a change
produces a permission error; chezmoi writes real files I can edit.

## Where things are

    flake.nix
    hosts/kei-nixos/            configuration.nix, hardware.nix, storage.nix
    modules/                    the only module root
    bin/set-password.sh         writes the initial password hash
    secrets/sops.yaml           tracked, not yet wired up

Modules are named for what they do. Each is a single file, imported explicitly
by `hosts/kei-nixos/configuration.nix`:

      modules/nix.nix                  flakes and the Nix daemon
      modules/shell.nix                bash completion, EDITOR
      modules/user.nix                 the kei account, sudo, linger
      modules/packages.nix             everything installed without config
      modules/git.nix                  git and lazygit
      modules/desktop/niri.nix         the compositor, plus config seeding
      modules/desktop/nautilus.nix      the file manager
      modules/gpu/nvidia.nix           the driver (amd.nix is the alternative)
      modules/services/greetd.nix      the login screen
      modules/services/filesystems.nix mounts
      modules/noctalia.nix             the shell and bar
      modules/sops.nix                 secrets, currently inert

There are no `default.nix` files tying a folder together; on one machine they
only make it harder to see what is pulling a file in.

## niri's config

niri writes `~/.config/niri/config.kdl` itself, from the default config that its
own version ships, and only when the file is missing. I seed that file on first
activation from `modules/desktop/niri.nix`, appending one line:

    include "overrides.kdl" optional=true

I never keep a copy of niri's default config, so it cannot fall behind the
installed version. `overrides.kdl` — the keybinds and monitor layout — is
chezmoi's, included as optional so a machine that has not applied chezmoi yet
still starts niri.

## Things I do by hand

### Hermes

Hermes does not come from this flake. Its build is heavy — it rebuilds the whole
Python dependency tree — and upstream calls its Nix support best-effort, so
letting `nixos-rebuild` depend on it means a bad upstream day can block a system
update. I install it into the `kei` profile instead:

    nix profile install github:NousResearch/hermes-agent#messaging   # ~33 MB closure
    # `default` is the full variant with every optional integration, ~700 MB
    hermes setup
    hermes gateway install        # installs a systemd user service
    systemctl --user status hermes-agent

`flake.nix` keeps the wiring in comments. If upstream ever publishes a binary
cache, uncomment it and it goes back to being declarative.

I leave `users.users.kei.linger` enabled in `modules/user.nix`; without it the
user service stops when the session ends.

### Secrets

Secrets are not set up yet. See the
[sops-nix docs](https://github.com/Mic92/sops-nix) for how to add them.

## Future consideration

A possible improvement is an interactive installer script that sets up the
entire NixOS configuration. It is not implemented yet.
