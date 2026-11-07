{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminals
    ghostty

    # Shell tools
    oh-my-posh
    zoxide
    btop
    fastfetch

    # Editor
    zed-editor
    package-version-server # Zed Nix Language Support

    # Dotfiles manager
    chezmoi

    # Browsers
    floorp-bin

    # Archivers. The base install has tar, gzip, bzip2, xz and zstd, but not
    # zip or 7z.
    p7zip
    unzip
    zip
  ];
}
