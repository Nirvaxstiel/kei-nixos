{ config, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # This module does nothing until `sops.secrets` has an entry.
  # FILL after you encrypt secrets/hermes.yaml and copy the age identity to
  # the box:
  #   sops.defaultSopsFile = ../../secrets/hermes.yaml;
  #   sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  #   sops.secrets."hermes-env" = { };
}
