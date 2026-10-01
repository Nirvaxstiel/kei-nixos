{ pkgs, ... }:

{
  # This name must match services.greetd.user (default "kei") in
  # modules/services/greetd.nix. Without a match, the greeter has no account
  # to start the session.
  users.users.kei = {
    isNormalUser = true;
    description = "Kei";
    shell = pkgs.bash;
    extraGroups = [ "wheel" "video" "audio" "input" ];
    # Home-manager runs hermes-agent as a systemd user unit. Without linger,
    # the user manager stops at logout. The agent stops with it.
    linger = true;
    # SECURITY: the activation reads the password hash from a runtime path.
    # That file is not copied into the nix store, and it is never committed to
    # git. Use bin/set-password.sh to make it. The script asks for the
    # password, hashes it, writes the file, then switches.
    hashedPasswordFile = "/etc/nixos/secrets/kei.hash";
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [ { command = "ALL"; options = [ "SETENV" ]; } ];
    }
  ];
}
