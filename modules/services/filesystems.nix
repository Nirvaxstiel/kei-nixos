{
  boot.supportedFilesystems = [ "ntfs" ];

  # UDisks2 lets the desktop mount removable media.
  services.udisks2.enable = true;

  # gvfs gives the file manager the trash, network shares and other virtual
  # filesystems.
  services.gvfs.enable = true;
}
