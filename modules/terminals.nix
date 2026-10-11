{ ... }:

{
  # Each terminal's config file belongs to the dotfiles repo, so these install
  # the package and nothing else. The shell integrations are off because
  # home-manager would otherwise append to ~/.bashrc and ~/.zshrc, which chezmoi
  # owns. rio has no integration options to disable.
  programs.ghostty = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs.rio.enable = true;
}
