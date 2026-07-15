{ pkgs, ... }:

{
  # --- DOMAIN: Identity ---
  # Name MUST match services.greetd.user (default "kei") in modules/services/greetd.nix,
  # otherwise the greeter has no account to start the session as.
  users.users.kei = {
    isNormalUser = true;
    description = "Kei";
    shell = pkgs.bash;
    extraGroups = [ "wheel" "video" "audio" "input" ];
    # SECURITY: password hash is read from a runtime path at activation —
    # the file is NOT copied to the nix store and is never committed to git.
    # Generate it once with bin/set-password.sh (prompts, hashes, writes the
    # file, then switches). See bin/set-password.sh for the full flow.
    hashedPasswordFile = "/etc/nixos/secrets/kei.hash";
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [ { command = "ALL"; options = [ "SETENV" ]; } ];
    }
  ];
}
