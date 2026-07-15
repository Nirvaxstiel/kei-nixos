{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # TRIVIA: one `nixos-rebuild switch` builds system + HM in one invocation,
  # but HM activates as a SEPARATE phase (user activation script) after the
  # system switch. Not a single ACID transaction — two phases, one command.
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users.kei = import ../../home/kei/home.nix;
  };
}
