{
  imports = [ ./graphics.nix ];

  # Turns on the hardware.nvidia module.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Required from driver 560 and later; the module asserts that it is not null.
  # Turing (RTX 20xx, GTX 16xx) and newer use the open kernel modules. The
  # userspace libraries stay proprietary.
  hardware.nvidia.open = true;

  # Wayland needs kernel mode setting. This also sets nvidia-drm.modeset=1 and
  # nvidia-drm.fbdev=1.
  hardware.nvidia.modesetting.enable = true;

  # The module loads these itself only when X11 is enabled. This host runs niri
  # on Wayland, so it has to list them.
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  nixpkgs.config.allowUnfreePackages = [
    "nvidia-settings"
    "nvidia-x11"
  ];
}
