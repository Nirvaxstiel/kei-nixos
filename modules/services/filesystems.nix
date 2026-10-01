{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  # This option turns on the UDisks2 service. That service automounts
  # removable media.
  services.udisks2.enable = true;
  
  # Make sure that the user environment has the tools for the GUI.
  services.gvfs.enable = true; 
}
