{ inputs, ... }:

{
  imports = [
    ../../modules/desktop/niri/home-manager.nix
    ../../modules/floorp.nix
    ../../modules/git/home-manager.nix
    # Hermes installs through `nix profile`. See the hermes-agent input in flake.nix.
    # ../../modules/hermes.nix
    ../../modules/noctalia.nix
    ../../modules/sops.nix
    ../../modules/terminals.nix
    ../../modules/zed.nix
  ];

  home = {
    username = "kei";
    homeDirectory = "/home/kei";
    stateVersion = "26.05";
  };
}
