{ inputs, ... }:

{
  imports = [
    inputs.noctalia-shell.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    # Starts the shell as a systemd user service with the session. If it does
    # not start after login, use niri spawn-at-startup instead.
    systemd.enable = true;
  };
}
