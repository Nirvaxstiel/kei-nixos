{ inputs, ... }:

{
  imports = [
    ./modules/noctalia.nix
    ./modules/shell.nix
  ];

  home = {
    username = "kei";
    homeDirectory = "/home/kei";
    stateVersion = "26.05";
  };
}
