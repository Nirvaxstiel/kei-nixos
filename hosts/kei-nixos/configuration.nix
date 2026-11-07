{ inputs, ... }:

{
  imports = [
    ./hardware.nix
    ./storage.nix

    ../../modules/nix.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/packages.nix

    ../../modules/git.nix
    ../../modules/gpu/nvidia.nix

    ../../modules/desktop/niri.nix
    ../../modules/desktop/nautilus.nix
    ../../modules/desktop/steam.nix

    ../../modules/services/filesystems.nix
    ../../modules/services/greetd.nix
    ../../modules/services/mullvad.nix

    ../../modules/noctalia.nix
    ../../modules/sops.nix
  ];

  networking.hostName = "kei-nixos";

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";
}
