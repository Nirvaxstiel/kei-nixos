{
  imports = [ ./graphics.nix ];

  # One GPU vendor per host: the host imports exactly one file from modules/gpu/.

  # The switch that enables the whole hardware.nvidia module — hardware.nvidia.enabled
  # is readOnly and derived from this list.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Required explicitly since driver 560 (nvidia.nix asserts `open != null`).
  # RTX 4070 Super is Turing-or-newer, the generation the open kernel modules
  # target, and the direction upstream is migrating to. The userspace libraries
  # remain proprietary regardless.
  hardware.nvidia.open = true;

  # Wayland requires KMS. The option default is `version >= 535`, i.e. an implicit
  # version comparison — pin the intent instead. This also makes the module set
  # nvidia-drm.modeset=1 and nvidia-drm.fbdev=1.
  hardware.nvidia.modesetting.enable = true;

  # nvidia.nix only force-loads these when services.xserver.enable is true, which a
  # Wayland-only niri host never sets (niri passes enableXWayland = false). Without
  # this the modules wait on udev autoload after fbdev is already needed.
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  # The userspace driver is unfree, and the nvidia module adds nvidia-settings to
  # environment.systemPackages unconditionally. Names are pnames (check-meta matches
  # lib.getName). allowUnfreePackages merges additively, so the unfree policy stays
  # inside the module that needs it and disappears with this file on a vendor swap.
  # `nvidia-kernel-modules` is deliberately absent: it is only built when open = false.
  nixpkgs.config.allowUnfreePackages = [
    "nvidia-settings"
    "nvidia-x11"
  ];
}
