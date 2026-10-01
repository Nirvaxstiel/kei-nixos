{ inputs, ... }:

{
  imports = [
    inputs.noctalia-shell.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    # Start the shell with the Wayland session (the niri-session target).
    # If the shell does not start after login, use niri spawn-at-startup
    # instead.
    systemd.enable = true;
  };
}
