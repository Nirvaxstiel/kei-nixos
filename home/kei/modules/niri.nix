{ config, lib, pkgs, ... }:

{
  # niri creates ~/.config/niri/config.kdl by itself when the file is missing,
  # and fills it from the default config that its own version ships. That default
  # is used unchanged and only gains one include line, so this repo never holds a
  # copy of it and cannot fall behind it.
  xdg.configFile."niri/overrides.kdl".source = ../config/niri/overrides.kdl;

  home.activation.niriSeeding = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="${config.home.homeDirectory}/.config/niri/config.kdl"
    if [ ! -e "$target" ]; then
      run ${pkgs.coreutils}/bin/install -Dm644 ${config.programs.niri.package.doc}/share/doc/niri/default-config.kdl "$target"
      printf '\ninclude "overrides.kdl"\n' >> "$target"
    fi
  '';
}
