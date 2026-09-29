{
  programs.niri.enable = true;

  # Thunar is the file manager; keep Nautilus out of the closure (the GTK portal covers FileChooser).
  programs.niri.useNautilus = false;
}
