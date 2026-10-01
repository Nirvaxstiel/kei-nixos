{ pkgs, ... }:

{
  # The base install has tar, gzip, bzip2, xz and zstd, but not zip or 7z.
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    zip
  ];
}
