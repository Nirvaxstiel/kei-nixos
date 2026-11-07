{ ... }:

{
  # The option is system-wide: it provides the 32-bit FHS environment, 32-bit
  # graphics, controller udev rules and the Remote Play firewall ports, and
  # installs the package itself. A `steam` entry in modules/user.nix would
  # duplicate it without any of that.
  programs.steam.enable = true;

  # steam and the unwrapped payload are unfree. Scoped to the two names so an
  # unfree dependency pulled in elsewhere still fails evaluation.
  nixpkgs.config.allowUnfreePackages = [ "steam" "steam-unwrapped" ];
}
