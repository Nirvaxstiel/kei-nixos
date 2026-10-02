{ ... }:

{
  # rio's config, themes and shaders belong to the dotfiles repo, which writes
  # them as real editable files. Declaring them here as well would put a
  # read-only store symlink over a file chezmoi owns.
  programs.rio.enable = true;
}
