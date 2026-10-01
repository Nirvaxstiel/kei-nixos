{
  imports = [ ./graphics.nix ];

  # One GPU vendor per host. The host imports exactly one file from
  # modules/gpu/.

  # This list turns on the hardware.nvidia module.
  # hardware.nvidia.enabled is readOnly, and it copies this list.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Driver version 560 and later need this option.
  # nvidia.nix asserts that the value is not null.
  # The RTX 4070 Super is Turing or newer, so the open kernel modules apply.
  # Upstream moves to these modules. The userspace libraries stay proprietary.
  hardware.nvidia.open = true;

  # Wayland needs kernel mode setting. The default of this option is the
  # comparison `version >= 535`. Set the value here to show the intention.
  # This option also sets nvidia-drm.modeset=1 and nvidia-drm.fbdev=1.
  hardware.nvidia.modesetting.enable = true;

  # nvidia.nix loads these modules at boot only when services.xserver.enable
  # is true. A Wayland-only niri host never sets that option, because niri
  # passes enableXWayland = false. Without this list, the modules wait for
  # udev after fbdev is necessary.
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  # The userspace driver is unfree. The nvidia module also always adds
  # nvidia-settings to environment.systemPackages. These names are pnames,
  # because check-meta matches lib.getName. allowUnfreePackages merges
  # additively. As a result, the unfree policy stays in the module that needs
  # it. A vendor swap removes the policy together with this file.
  # `nvidia-kernel-modules` is absent on purpose, because the module builds
  # that package only when open = false.
  nixpkgs.config.allowUnfreePackages = [
    "nvidia-settings"
    "nvidia-x11"
  ];
}
