{ pkgs, ... }:

{
  # Every config file these apps read lives in the dotfiles repo, so this module
  # installs the packages and nothing else.
  #
  # The terminals deliberately do not use home-manager's programs.* modules:
  # those append shell integration to ~/.bashrc and ~/.zshrc, which chezmoi
  # owns. rio has no integration options to disable in the first place.
  environment.systemPackages = with pkgs; [
    # Terminals
    ghostty
    rio
    wezterm

    # Editor
    zed-editor

    # Browser
    floorp

    # Archivers. The base install has tar, gzip, bzip2, xz and zstd, but not
    # zip or 7z.
    p7zip
    unzip
    zip
  ];
}
