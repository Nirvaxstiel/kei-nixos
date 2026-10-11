{
  # Bash completion is system-level; the rc files themselves belong to the
  # dotfiles repo.
  programs.bash.completion.enable = true;

  # Exports EDITOR system-wide. This replaces the home-manager initExtra that
  # used to write it into ~/.bashrc, which chezmoi now owns.
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
}
