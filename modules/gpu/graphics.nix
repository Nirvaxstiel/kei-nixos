{
  # Without this there is no /run/opengl-driver at all and every compositor
  # falls back to software rendering. The driver set always includes mesa
  # (hardware.graphics.package defaults to pkgs.mesa), so the free drivers stay
  # usable no matter which vendor module is imported.
  hardware.graphics.enable = true;

  # Default is false in 26.05 (all-firmware.nix: default = enableAllFirmware).
  # amdgpu, i915 and wifi all need linux-firmware to initialise; the NVIDIA
  # driver ships its own, so this exists to keep a future card swap from landing
  # on a box with no firmware. linux-firmware is licensed
  # unfreeRedistributableFirmware with no `free = false`, so check-meta treats it
  # as free and it needs no allowUnfree entry.
  hardware.enableRedistributableFirmware = true;
}
