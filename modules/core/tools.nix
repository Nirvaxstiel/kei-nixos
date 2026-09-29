{ pkgs, ... }:

{
  # NixOS base ships tar/gzip/bzip2/xz/zstd only — zip and 7z are NOT included.
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    zip
  ];
}
