{
  # Without this option, there is no /run/opengl-driver.
  # Then each compositor falls back to software rendering.
  # The driver set always contains mesa, because hardware.graphics.package
  # defaults to pkgs.mesa. As a result, the free drivers stay available for
  # each vendor module.
  hardware.graphics.enable = true;

  # The default is false in 26.05 (all-firmware.nix:
  # default = enableAllFirmware). amdgpu, i915 and wifi need linux-firmware
  # to start. The NVIDIA driver supplies its own firmware. This option makes
  # sure that a new card has firmware after a swap.
  # linux-firmware uses the unfreeRedistributableFirmware license. That
  # license has no `free = false` key, so check-meta treats it as free.
  # As a result, the firmware needs no allowUnfree entry.
  hardware.enableRedistributableFirmware = true;
}
