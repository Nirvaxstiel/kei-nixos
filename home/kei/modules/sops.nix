{ config, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Inert until `sops.secrets` is non-empty. FILL once secrets/hermes.yaml is
  # encrypted and the age identity is on the box:
  #   sops.defaultSopsFile = ../../secrets/hermes.yaml;
  #   sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  #   sops.secrets."hermes-env" = { };
}
