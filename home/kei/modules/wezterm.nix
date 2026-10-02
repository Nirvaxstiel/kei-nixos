{ ... }:

{
  # The wezterm config is its own repository, cloned by chezmoi on a fresh
  # machine. Nix installs the terminal only; a second clone here would race it.
  programs.wezterm.enable = true;
}
