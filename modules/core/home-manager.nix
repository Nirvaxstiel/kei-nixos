{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # TRIVIA: one `nixos-rebuild switch` builds the system and HM together.
  # HM then activates in a separate phase, after the system switch. This is not
  # one atomic transaction. It is two phases and one command.
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users.kei = import ../../home/kei/home.nix;
  };
}
