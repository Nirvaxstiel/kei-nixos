# kei-nixos

This is my personal NixOS config: the specific setup I use on one machine. To
reuse it, replace all instances of `kei-nixos` with the desired hostname and
`kei` with the desired user name. For the actual dotfiles, see
[my dotfiles repo](https://github.com/Nirvaxstiel/dotfiles).

The repo builds the system: packages, services, the GPU driver, the login
screen, and the `kei` account. I keep most personal config files out of it —
`rio/config.toml`, the shell rc files and the rio themes live in chezmoi
instead. home-manager installs files as read-only symlinks into the Nix store,
so saving a change produces a permission error; chezmoi writes real files I can
edit.

I keep niri's keybinds at `modules/desktop/niri/overrides.kdl`. They stay here
because they depend on what this repo installs: `Mod+T` starts ghostty, and the
Noctalia binds call Noctalia's IPC. A terminal change belongs in the same commit
as its keybind.

## Where things are

    flake.nix
    hosts/kei-nixos/            configuration.nix, hardware.nix, storage.nix
    home/kei/home.nix           home-manager entry point
    modules/                    the only module root
    bin/set-password.sh         writes the initial password hash
    secrets/sops.yaml           tracked, not yet wired up

Modules are grouped by what they do, not by which system reads them. When a
feature has both a system side and a user side, it gets a directory with one
file per side:

      modules/git/nixos.nix                    programs.git, the binary
      modules/git/home-manager.nix             programs.git + lazygit, user config
      modules/desktop/niri/nixos.nix           programs.niri
      modules/desktop/niri/home-manager.nix    overrides.kdl + default-config seeding
      modules/desktop/niri/overrides.kdl       keybinds and output layout

When a feature only has one side, it is a single file. The importing file
decides the side: `hosts/kei-nixos/configuration.nix` imports the system
modules, `home/kei/home.nix` imports the user ones. Both spell their imports
out. There are no `default.nix` files tying a folder together, because on one
machine they only make it harder to see what is pulling a file in.

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

`flake.nix` and `home/kei/home.nix` keep the Hermes wiring in comments. If
upstream ever publishes a binary cache, uncomment both and it goes back to being
declarative.

I leave `users.users.kei.linger` enabled in `modules/user.nix`; without it the
user service stops when the session ends.

### Secrets

Secrets are not set up yet. See the
[sops-nix docs](https://github.com/Mic92/sops-nix) for how to add them.
