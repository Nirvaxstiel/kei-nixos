{
  imports = [ ./graphics.nix ];

  # amdgpu is part of the standard kernel, and its firmware comes from
  # hardware.enableRedistributableFirmware in graphics.nix. mesa is the driver
  # set. Nothing here is unfree: ROCm uses the MIT license, so this file needs
  # no allowUnfree entry.
}
