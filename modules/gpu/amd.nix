{
  imports = [ ./graphics.nix ];

  # amdgpu is in the standard kernel. Its firmware comes from
  # hardware.enableRedistributableFirmware in graphics.nix. mesa is the
  # driver set. No AMD component is unfree, because ROCm uses the MIT
  # license. As a result, this file needs no allowUnfree entry. No entry
  # arrives from the NVIDIA module that this file replaces.
}
