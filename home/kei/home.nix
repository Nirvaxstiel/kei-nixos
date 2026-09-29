{ inputs, ... }:

{
  imports = [
    ./modules/floorp.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/noctalia.nix
    ./modules/shell.nix
    ./modules/zed.nix
  ];

  home = {
    username = "kei";
    homeDirectory = "/home/kei";
    stateVersion = "26.05";
  };
}
