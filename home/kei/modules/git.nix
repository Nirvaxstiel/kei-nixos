{
  programs.git = {
    enable = true;
    settings.user = {
      name = "REPLACE_WITH_GIT_NAME";
      email = "replace@example.com";
    };
  };

  programs.lazygit.enable = true;
}
