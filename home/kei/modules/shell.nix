{ pkgs, ... }:

{
  # Set up through Nix instead of a third-party shell flake, so the shell config
  # stays in this repo and needs no extra dependency.
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      export EDITOR=${pkgs.vim}/bin/vim
    '';
  };
}
