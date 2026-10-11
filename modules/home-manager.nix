{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # One `nixos-rebuild switch` builds the system and the user config together,
  # but they activate in two separate phases. If the second phase fails, the
  # system phase has already switched.
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users.kei = import ../home/kei/home.nix;
  };
}
