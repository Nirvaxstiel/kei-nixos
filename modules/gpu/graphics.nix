{
  # Without this there is no /run/opengl-driver, and every compositor falls back
  # to software rendering. The driver set always includes mesa, so the free
  # drivers keep working when the GPU changes.
  hardware.graphics.enable = true;

  # amdgpu, i915 and wifi cards need linux-firmware to start. The NVIDIA driver
  # ships its own, so an NVIDIA-only machine boots without this and then fails
  # to initialise an AMD card after a swap. This option is off by default.
  hardware.enableRedistributableFirmware = true;
}
