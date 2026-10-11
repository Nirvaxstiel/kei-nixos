{
  programs.git = {
    enable = true;
    # Anonymous placeholder: Nix owns this file, so set the identity here.
    settings.user = {
      name = "kei";
      email = "kei@localhost";
    };
  };

  programs.lazygit.enable = true;
}
