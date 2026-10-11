{ inputs, ... }:

{
  imports = [
    ./hardware.nix
    ./storage.nix

    ../../modules/home-manager.nix
    ../../modules/nix.nix
    ../../modules/shell.nix
    ../../modules/tools.nix
    ../../modules/user.nix

    ../../modules/git/nixos.nix
    ../../modules/gpu/nvidia.nix

    ../../modules/desktop/niri/nixos.nix
    ../../modules/desktop/thunar.nix

    ../../modules/services/filesystems.nix
    ../../modules/services/greetd.nix
  ];

  networking.hostName = "kei-nixos";

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";
}
