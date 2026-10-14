{ inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.default
  ];

  # This module does nothing until a secret is declared. To use it, encrypt
  # secrets/<name>.yaml, copy the age identity to the machine, then add:
  #   sops.defaultSopsFile = ../../secrets/<name>.yaml;
  #   sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  #   sops.secrets."<name>" = { };
}
