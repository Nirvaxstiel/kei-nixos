{ pkgs, ... }:

{
  # Nautilus is the file manager. programs.niri.useNautilus only adds it to the
  # D-Bus portal path; the binary and desktop entry still need to be in the
  # system profile for launchers and `xdg-open` to find them.
  environment.systemPackages = [
    pkgs.nautilus

    # Noctalia's GTK template selects adw-gtk3 / adw-gtk3-dark through
    # gsettings. The theme must exist in the profile for that value to resolve.
    pkgs.adw-gtk3
  ];

  # Nautilus is a consumer of gvfs and udisks2, which are enabled system-wide
  # in modules/services/filesystems.nix. Enabling them here as well would only
  # duplicate the same option across two modules.

  # Nautilus and Noctalia's GTK template both persist settings through dconf.
  # Without the dconf service, gsettings writes fall back to a memory backend
  # and are lost at logout.
  programs.dconf.enable = true;

  # Make Nautilus the handler for "open folder" from browsers and other apps.
  # A user-level ~/.config/mimeapps.list still overrides this; chezmoi owns that.
  xdg.mime.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
}
