{ pkgs, ... }:

{
  # This name must match services.greetd.user in modules/services/greetd.nix.
  # Without a match the login manager has no account to start a session as.
  users.users.kei = {
    isNormalUser = true;
    description = "Kei";
    shell = pkgs.bash;
    extraGroups = [ "wheel" "video" "audio" "input" ];
    # hermes-agent runs as a systemd user unit. Without linger the user manager
    # stops at logout, and the agent stops with it.
    linger = true;
    # The hash is read at switch time from this path. The file never enters the
    # nix store and is never committed. bin/set-password.sh writes it.
    hashedPasswordFile = "/etc/nixos/secrets/kei.hash";
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [ { command = "ALL"; options = [ "SETENV" ]; } ];
    }
  ];
}
