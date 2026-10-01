{
  programs.niri.enable = true;

  # Thunar is the file manager, so Nautilus stays out of the closure. The GTK
  # portal provides the file chooser.
  programs.niri.useNautilus = false;
}
