{
  # FILL: set your real name/email; git commit will prompt without these.
  programs.git = {
    enable = true;
    settings.user = {
      name = "REPLACE_WITH_GIT_NAME";
      email = "replace@example.com";
    };
  };

  programs.lazygit.enable = true;
}
