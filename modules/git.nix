{
  # Anonymous placeholder: Nix owns this file, so set the identity here. This
  # writes /etc/gitconfig, which applies to every user on the machine. The
  # per-user ~/.gitconfig stays free for the dotfiles repo.
  programs.git = {
    enable = true;
    config.user = {
      name = "kei";
      email = "kei@localhost";
    };
  };

  programs.lazygit.enable = true;
}
