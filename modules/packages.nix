{ pkgs, ... }:

{
  # System scope: available to root, to systemd units and to every account.
  # Personal applications live in modules/user.nix.
  environment.systemPackages = with pkgs; [
    # Archivers. The base install has tar, gzip, bzip2, xz and zstd, but not
    # zip or 7z.
    p7zip
    unzip
    zip

    # $EDITOR target. EDITOR is exported system-wide (modules/shell.nix), so
    # this binary must resolve outside the user profile. Zed is not on root's
    # PATH; the wrapper degrades to nano there.
    (writeShellScriptBin "zed-edit" ''
      if ! zeditor --wait "$@"; then
        echo "zed-edit: zed failed, falling back to nano" >&2
        exec nano "$@"
      fi
    '')

    # X server for X11 clients. niri 26.04 hosts X11 via xwayland-satellite:
    # it spawns the satellite on demand and exports DISPLAY into the systemd
    # user environment. Missing binary = "Unable to open a connection to X"
    # in every X11 app (Steam), logged as "error spawning xwayland-satellite".
    xwayland-satellite
  ];
}
