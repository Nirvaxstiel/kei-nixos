{ config, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # This module does nothing until a secret is declared. To use it, encrypt
  # secrets/<name>.yaml, copy the age identity to the machine, then add:
  #   sops.defaultSopsFile = ../../secrets/<name>.yaml;
  #   sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  #   sops.secrets."<name>" = { };
}
