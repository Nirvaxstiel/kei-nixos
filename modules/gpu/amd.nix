{
  imports = [ ./graphics.nix ];

  # amdgpu is in the stock kernel and its firmware arrives with
  # hardware.enableRedistributableFirmware in graphics.nix; mesa is the driver set.
  # Nothing AMD requires is unfree — ROCm is MIT — so no allowUnfree entry belongs
  # in this file, and none is inherited from the NVIDIA module it replaces.
}
