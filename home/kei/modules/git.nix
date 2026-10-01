{
  # FILL: set your name and email. Without these values, git commit asks for
  # them each time.
  programs.git = {
    enable = true;
    settings.user = {
      name = "REPLACE_WITH_GIT_NAME";
      email = "replace@example.com";
    };
  };

  programs.lazygit.enable = true;
}
