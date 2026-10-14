{ config, pkgs, ... }:

let
  user = config.users.users.kei;
in
{
  programs.niri.enable = true;

  # Thunar is the file manager, so Nautilus stays out of the closure. The GTK
  # portal provides the file chooser.
  programs.niri.useNautilus = false;

  # niri creates ~/.config/niri/config.kdl by itself when the file is missing,
  # and fills it from the default config that its own version ships. That
  # default is used unchanged and only gains one include line, so this repo
  # never holds a copy of it and cannot fall behind it.
  #
  # Activation runs as root, so the directory and the file are chowned to the
  # user: niri expects a config it can edit.
  #
  # overrides.kdl belongs to the dotfiles repo. The include is marked optional
  # so a machine that has not applied chezmoi yet still starts niri.
  system.activationScripts.niriSeeding = {
    deps = [ "users" ];
    text = ''
      dir="${user.home}/.config/niri"
      ${pkgs.coreutils}/bin/install -d -m 755 -o ${user.name} -g ${user.group} "$dir"
      target="$dir/config.kdl"
      if [ ! -e "$target" ]; then
        ${pkgs.coreutils}/bin/install -m 644 \
          ${config.programs.niri.package.doc}/share/doc/niri/default-config.kdl \
          "$target"
        printf '\ninclude "overrides.kdl" optional=true\n' >> "$target"
        ${pkgs.coreutils}/bin/chown ${user.name}:${user.group} "$target"
      fi
    '';
  };
}
