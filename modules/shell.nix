{
  # Bash completion is system-level; the rc files themselves belong to the
  # dotfiles repo.
  programs.bash.completion.enable = true;
  programs.vim.enable = true;

  # zed-edit (modules/packages.nix) waits for the buffer to close and falls
  # back to nano when Zed cannot start.
  environment.variables.EDITOR = "zed-edit";
  environment.variables.VISUAL = "zed-edit";

  # nixpkgs renames Zed's `zed` CLI to `zeditor` (pkgs.zed is the Brimdata tool).
  environment.shellAliases.zed = "zeditor";
}
