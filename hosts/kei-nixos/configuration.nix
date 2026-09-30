{ inputs, ... }:

{
  imports = [
    ./hardware.nix
    ./storage.nix
    ../../modules/core
    ../../modules/desktop
    ../../modules/services
    ../../modules/gpu/nvidia.nix
  ];

  networking.hostName = "kei-nixos";

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";
}
