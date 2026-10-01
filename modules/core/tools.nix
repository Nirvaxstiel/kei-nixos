{ pkgs, ... }:

{
  # The NixOS base install contains tar, gzip, bzip2, xz and zstd. It does not
  # contain zip or 7z.
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    zip
  ];
}
