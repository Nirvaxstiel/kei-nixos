{ inputs, ... }:

{
  imports = [
    ./modules/floorp.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    # Hermes installs through `nix profile`. See the hermes-agent input in flake.nix.
    # ./modules/hermes-agent.nix
    ./modules/niri.nix
    ./modules/noctalia.nix
    ./modules/rio.nix
    ./modules/shell.nix
    ./modules/sops.nix
    ./modules/wezterm.nix
    ./modules/zed.nix
  ];

  home = {
    username = "kei";
    homeDirectory = "/home/kei";
    stateVersion = "26.05";
  };
}
