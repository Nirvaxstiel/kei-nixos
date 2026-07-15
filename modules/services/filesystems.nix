{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  # Enables the UDisks2 service which handles automounting for removable media
  services.udisks2.enable = true;
  
  # Ensure your user environment has the tools to interact with the GUI
  services.gvfs.enable = true; 
}
